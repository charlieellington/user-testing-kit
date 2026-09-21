# CLAUDE.md — the brief for the agent analysing the sessions

You are analysing user-testing sessions: screen recordings of real people using an interface, with a transcript of what was said. Your job is to turn them into findings a team can build from, where every finding carries the quote, the time and the frame. Read this whole file before touching anything.

## What you have

`sessions/<YYYY-MM-DD-HHMM-name>/`, one folder per session:

- `transcript.txt` — timestamped text (Otter blocks, SRT or VTT from whisper, anything with a time per speaker turn). Read it as text; nothing is parsed.
- `recording.mp4` — the screen recording. You never watch it. You sample it with the contact sheet and pull stills from it.
- `meta.json` — participant, initial, role, the offset. Create it from `templates/meta.json` if it is missing.
- Anything the participant sent afterwards (an email, a screenshot). Read it with the session it belongs to.

Tools, run from the repo root, both need ffmpeg:

- `bin/contact-sheet.sh <session-dir> [every-seconds]` — one frame every N seconds, tiled into numbered sheets, plus `contact-sheets/index.txt` with the time of every cell.
- `bin/frames-at.sh <session-dir> <m:ss>[:<slug>] ...` — the exact still at each moment (transcript time; the offset is applied for you), named `<INITIAL>-<mmss>-<slug>.jpg`.

## The procedure, per session

1. **See the whole session first.** `bin/contact-sheet.sh sessions/<s> 15` (use 30 for sessions over an hour). Read every sheet **in one message**, with `index.txt` open so you know each cell's time. Write yourself a short note: what was on screen over time, which tools the participant used, where they seemed to stall.
2. **Read the whole transcript.** All of it, before choosing anything. Note the participant's role, the tasks they were given, and the words they used for things.
3. **Measure the offset.** The transcript's clock and the recording's clock almost never start together. Find one distinctive moment you can see on a sheet and find in the transcript: a page change they narrate, a click, a phrase. `offset_seconds = recording time − transcript time`. Write it into `meta.json` with a note of how you measured it. If no moment is obvious, pull two or three candidate frames around a narrated action and adjust until the frame matches the words.
4. **Choose the moments.** Eight to fifteen per hour is normal. Look for: hesitation or silence; a misread label ("what does this mean?"); doing something other than what they said they would do; a workaround or a personal tool (paper, a spreadsheet, the inbox); an error or a dead end; something they liked; a fact about their real workflow. Write each as `m:ss:slug`.
5. **Pull and look.** `bin/frames-at.sh sessions/<s> 0:22:backlog-label 1:13:start-job ...`. Look at every frame. If one is a second early or late, pull again at ±1–3 s and delete the miss. Never cite a frame you have not looked at.
6. **Write the findings** into `findings/`, using the prompts:
   - `prompts/01-strategy-read.md` → `findings/01-strategy-read.md`
   - `prompts/02-bugs-and-small-fixes.md` → `findings/02-bugs-and-small-fixes.md`
   - `templates/problem-register.md` → `findings/03-problem-register.md`

   With several sessions, do steps 1–5 for each before writing anything, then write across all of them: "three of five did X" is the finding, not five separate notes.

## Rules

- **Cite everything.** `Name m:ss–m:ss (X-mmss)`: the name, the span in the transcript, the frame id. Quote the words as said; do not tidy them.
- **Say and do.** When the words and the screen disagree, that is the finding. Say which is which.
- **Never compute a time you have not checked against a frame.** Clocks drift, the offset is per session, and the frame is the truth.
- **Never infer what was on screen from the transcript alone.** Pull the frame.
- **Never invent.** If the evidence is thin, say "one participant, once". If a finding has no frame because nothing was on screen, say so.
- **Keep raw raw.** Do not edit transcripts or recordings. Findings live in `findings/` and point back.
- **Privacy.** Real names stay inside the team's private copy. Anything that leaves the team is anonymised: participant → role or initial, client names → fictional. Never commit a real recording to a public repo.
- **Technical failures are not usability findings.** A crash, a slow load, a demo-data glitch goes in its own short list at the end of file 02.
- **What you write goes to a builder.** File 02 is read by a second agent that fixes things, so every row needs a size, a route, and a place to look in the code if you have it.

## Output formats

The shapes matter more than the prose: a table a builder can work down, a register nothing falls out of, a strategy read someone can disagree with line by line. The prompts and `templates/` define them; `example/findings/` shows a finished set.
