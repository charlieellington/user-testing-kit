# Prompt 01 — the strategy read

Write `findings/01-strategy-read.md`. It answers one question: **what did the sessions show, and what should we build?** It is read by the person deciding the next piece of work, so it must be arguable line by line: every claim carries the quote, the time and the frame.

## Inputs

Every session in `sessions/` (transcript, contact sheets, the frames you pulled, `meta.json`), anything a participant sent afterwards, and the product as it stands if you have the code.

## Shape

1. **What the sessions said.** A table first, one row per participant: role, what they actually do today (their real tools and habits, in their words), what the product is for them, the frames that show it. Then the pattern across participants, in one paragraph. Then their words on what is wrong, grouped by theme, every line cited. Then what they liked.
2. **The diagnosis.** Why the problems in §1 happen. Separate what the interface gets wrong from what the underlying process gets wrong. Name the say/do gaps: where the words and the screen disagreed.
3. **What to build.** The smallest change that answers §2, then the fuller redesign if one is needed. Where there is a real choice, the options with their trade-offs and a recommendation, not a menu.
4. **What needs a decision.** The questions only the product owner can answer, numbered, each with the evidence behind it.
5. **What we did not learn.** Where the sessions were thin, where the harness got in the way, what to test next time.

## Rules

- Citations: `Name m:ss–m:ss (X-mmss)`. Quote as said; do not tidy people's words.
- Count across sessions: "three of five" beats "some".
- Say and do: when words and screen disagree, say which you believe and why.
- No solutions in §1. Evidence first; the design comes after the diagnosis.
- If a later document replaces part of this one, mark that part superseded at the top rather than rewriting history.
