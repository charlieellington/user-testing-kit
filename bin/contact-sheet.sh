#!/usr/bin/env bash
# contact-sheet.sh — the "see the whole session before you choose" step.
# Plain English: a research recording is an hour long, and nobody, human or agent, should pick
# moments from the transcript alone. This pulls one frame every N seconds and tiles them into
# numbered sheets (6 across, 5 down = 30 frames a sheet) so an agent can read a whole session in
# a few images and know what was on screen when. Each cell's time is fixed by its position, and
# contact-sheets/index.txt lists the time of every cell, so nothing is guessed.
# Usage: bin/contact-sheet.sh <session-dir> [every-seconds=15]
#   reads  <session-dir>/recording.mp4 (or the file named in meta.json) 
#   writes <session-dir>/contact-sheets/sheet-01.jpg ... and index.txt
# Needs ffmpeg + ffprobe.
set -euo pipefail
SESSION="${1:?usage: contact-sheet.sh <session-dir> [every-seconds]}"
EVERY="${2:-15}"
COLS=6; ROWS=5; PER=$((COLS * ROWS)); CELL_W=320
[ -d "$SESSION" ] || { echo "contact-sheet: no such session dir: $SESSION" >&2; exit 1; }
meta_get() { # meta_get <key> <default> — one string value out of meta.json without a JSON tool
  local v=""; [ -f "$SESSION/meta.json" ] && v=$(grep -o "\"$1\"[[:space:]]*:[[:space:]]*\"[^\"]*\"" "$SESSION/meta.json" | head -1 | sed 's/.*:[[:space:]]*"\(.*\)"$/\1/') || true
  echo "${v:-$2}"; }
REC="$SESSION/$(meta_get recording recording.mp4)"
[ -f "$REC" ] || { echo "contact-sheet: no recording at $REC" >&2; exit 1; }
OUT="$SESSION/contact-sheets"; mkdir -p "$OUT"; rm -f "$OUT"/sheet-*.jpg "$OUT/index.txt"
DUR=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$REC")
N=$(awk "BEGIN{print int($DUR / $EVERY) + 1}")
ffmpeg -y -loglevel error -i "$REC" \
  -vf "fps=1/${EVERY},scale=${CELL_W}:-2,tile=${COLS}x${ROWS}:padding=4:margin=6:color=white" \
  -q:v 4 "$OUT/sheet-%02d.jpg"
{
  echo "# $(basename "$SESSION") — one frame every ${EVERY}s, ${COLS} across x ${ROWS} down, read left-to-right then top-to-bottom"
  echo "# recording: $(basename "$REC")  duration: ${DUR}s  frames: $N"
  for ((k = 0; k < N; k++)); do
    sheet=$((k / PER + 1)); cell=$((k % PER)); row=$((cell / COLS + 1)); col=$((cell % COLS + 1)); t=$((k * EVERY))
    printf "sheet-%02d  row %d col %d  %d:%02d\n" "$sheet" "$row" "$col" $((t / 60)) $((t % 60))
  done
} > "$OUT/index.txt"
SHEETS=$(ls "$OUT"/sheet-*.jpg | wc -l | tr -d ' ')
echo "contact-sheet: $(basename "$SESSION")  ${DUR}s  ->  $N frames on $SHEETS sheet(s) in $OUT  (every ${EVERY}s; cell k = k*${EVERY}s; see index.txt)"
echo "NEXT: read every sheet in ONE message, with index.txt open, before choosing any moment."
