# The example — a complete run, staged

**What this is (plain English):** one session taken all the way through the kit, so you can see every file the method produces before you record anything. It is staged. The interface is a fictional practice-management screen (`interface/index.html`), the participant is scripted, the recording is a puppet show driven by `interface/record.mjs`, and the transcript was written to match. No real product, practice, participant or client appears anywhere in it.

Why staged rather than real: a real session shows real people's names, real screens and real client data. None of that can be published. The shape of the method can.

## What is here

| Path | What |
|---|---|
| `sessions/2026-09-21-1000-priya-nair/transcript.txt` | The transcript, Otter-style: `Speaker  m:ss` then the words. |
| `sessions/2026-09-21-1000-priya-nair/recording.mp4` | The screen recording, 1:52, silent. |
| `sessions/2026-09-21-1000-priya-nair/meta.json` | Participant, initial, and the measured offset (−15 s) with how it was measured. |
| `sessions/2026-09-21-1000-priya-nair/contact-sheets/` | `bin/contact-sheet.sh … 10`: one sheet of 12 frames, plus `index.txt` with the time of each cell. |
| `sessions/2026-09-21-1000-priya-nair/frames/` | `bin/frames-at.sh …`: the seven stills the agent chose, named for citation. |
| `findings/01-strategy-read.md` | What the session showed and what to build. |
| `findings/02-bugs-and-small-fixes.md` | Six sized, routed, cited rows a builder can work down. |
| `findings/03-problem-register.md` | Every problem, numbered, with where it is solved. |

## The commands that were run

```sh
bin/contact-sheet.sh example/sessions/2026-09-21-1000-priya-nair 10
bin/frames-at.sh example/sessions/2026-09-21-1000-priya-nair \
  0:22:backlog-label 0:38:two-of-four 1:04:one-to-acknowledge \
  1:13:start-job-no-change 1:17:start-job-grey 1:52:target-date-past 2:00:unlabelled-date
```

## The offset, worked

The transcript's clock starts 15 seconds before the recording's. Priya says "I'll try Backlog" at transcript 0:31–0:33; on the contact sheet the Backlog page is already up in the 0:20 cell and not in the 0:10 cell, and a frame pulled around there shows the change at recording 0:18. So `offset_seconds = 18 − 33 = −15`, and every frame above was pulled at transcript time − 15 s. Get this wrong and `P-0113` would show a greyed button instead of the moment before it.

## Re-recording it

```sh
cd example/interface
npm i playwright && npx playwright install chromium   # or: PLAYWRIGHT_FROM=/path/to/a/project/that/has/playwright
node record.mjs
```

Then run the two commands above again. The timeline lives in `record.mjs`; change it and the transcript together.
