#!/usr/bin/env bash
# frames-at.sh — pull the exact still at each moment that matters.
# Plain English: once the agent has read the transcript and the contact sheets it names the moments
# in TRANSCRIPT time. This pulls one frame per moment from the recording, applying the session's
# transcript-to-recording offset from meta.json, and names each file so the citation writes itself:
# <INITIAL>-<mmss>[-<slug>].jpg, e.g. P-0041-backlog-label.jpg. Look at every frame it makes.
# Usage: bin/frames-at.sh <session-dir> <m:ss>[:<slug>] [<m:ss>[:<slug>] ...]
#   e.g. bin/frames-at.sh sessions/2026-09-21-1000-priya-nair 0:22:backlog-label 1:13
#   reads  <session-dir>/recording.mp4 + meta.json  (initial, offset_seconds = recording − transcript)
#   writes <session-dir>/frames/<INITIAL>-<mmss>[-<slug>].jpg and appends to frames/index.txt
# Needs ffmpeg + ffprobe. Slugs are words and dashes, never digits only.
set -euo pipefail
SESSION="${1:?usage: frames-at.sh <session-dir> <m:ss>[:<slug>] ...}"; shift
[ $# -ge 1 ] || { echo "frames-at: give at least one moment, e.g. 0:41:backlog-label" >&2; exit 1; }
[ -d "$SESSION" ] || { echo "frames-at: no such session dir: $SESSION" >&2; exit 1; }
meta_get() { local v=""; [ -f "$SESSION/meta.json" ] && v=$(grep -o "\"$1\"[[:space:]]*:[[:space:]]*\"\{0,1\}[^,}\"]*\"\{0,1\}" "$SESSION/meta.json" | head -1 | sed 's/^[^:]*:[[:space:]]*//; s/^"//; s/"$//') || true; echo "${v:-$2}"; }
REC="$SESSION/$(meta_get recording recording.mp4)"
INITIAL=$(meta_get initial X)
OFF=$(meta_get offset_seconds 0)
[ -f "$REC" ] || { echo "frames-at: no recording at $REC" >&2; exit 1; }
DUR=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$REC")
OUT="$SESSION/frames"; mkdir -p "$OUT"
[ "$OFF" = "0" ] && echo "frames-at: note — offset_seconds is 0 in meta.json; measure it once per session (see README) or frames will be off." >&2
for tok in "$@"; do
  IFS=':' read -ra parts <<< "$tok"; nums=(); slug_parts=()
  for p in "${parts[@]}"; do
    if [ ${#slug_parts[@]} -eq 0 ] && [[ "$p" =~ ^[0-9]+$ ]]; then nums+=("$p"); else slug_parts+=("$p"); fi
  done
  case ${#nums[@]} in
    2) t=$((10#${nums[0]} * 60 + 10#${nums[1]}));;
    3) t=$((10#${nums[0]} * 3600 + 10#${nums[1]} * 60 + 10#${nums[2]}));;
    *) echo "frames-at: bad moment '$tok' — use m:ss or h:mm:ss, then :slug" >&2; exit 1;;
  esac
  slug=""; [ ${#slug_parts[@]} -gt 0 ] && slug=$(IFS='-'; echo "${slug_parts[*]}")
  hh=$((t / 3600)); mm=$(((t % 3600) / 60)); ss=$((t % 60))
  if [ $hh -gt 0 ]; then id=$(printf "%s-%d%02d%02d" "$INITIAL" $hh $mm $ss); shown=$(printf "%d:%02d:%02d" $hh $mm $ss)
  else id=$(printf "%s-%02d%02d" "$INITIAL" $mm $ss); shown=$(printf "%d:%02d" $mm $ss); fi
  rec_t=$(awk "BEGIN{v = $t + ($OFF); if (v < 0) v = 0; printf \"%.2f\", v}")
  if awk "BEGIN{exit !($rec_t > $DUR)}"; then echo "frames-at: $tok is past the end of the recording (${DUR}s) — skipped" >&2; continue; fi
  name="$id${slug:+-$slug}.jpg"
  ffmpeg -y -loglevel error -ss "$rec_t" -i "$REC" -frames:v 1 -q:v 2 "$OUT/$name"
  printf "%-44s transcript %-8s recording %ss\n" "$name" "$shown" "$rec_t" | tee -a "$OUT/index.txt"
done
echo "NEXT: look at every frame in $OUT. If one is a second early or late, pull again at ±1–3 s and delete the miss. Cite as: Name m:ss–m:ss ($INITIAL-mmss)."
