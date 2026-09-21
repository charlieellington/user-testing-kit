# Prompt 02 — bugs, fixes and small changes

Write `findings/02-bugs-and-small-fixes.md`: everything the sessions turned up that is **not** the redesign in file 01, listed so nothing is lost, sized, routed and cited. This file goes straight to a second agent (or a developer) to work through, so every row must stand on its own.

## Shape

Start with the key. Then:

1. **Already fixed** since the sessions, so nobody re-raises them. Skip if none.
2. **Small** — copy, labels, defaults, one-file fixes.
3. **Medium** — needs a decision, a migration, or more than a day.
4. **Large, or belongs to the redesign** — one line each, pointing at file 01.
5. **Technical failures and demo glitches** — kept apart from usability.

Each row: `#` · what (the finding, with the quote, and the fix if it is obvious) · evidence (`Name m:ss–m:ss (X-mmss)`) · where (file and line if you have the code; the screen if not) · size · state · route.

## Key

- **Size:** S under half a day · M half a day to two days, or needs a migration or a decision · L a week or more, or part of the redesign.
- **State:** ✅ fixed · 🔧 open · 🔍 verify first · ⚖️ needs a decision (say whose) · 🗂 ops, data or docs, not code.
- **Route:** now · next · later. Use your own sprint names if you have them.

## Rules

- One row per problem even if three people hit it; list all three citations.
- Propose the fix in the row when it is obvious ("rename to *To be started*"); leave it open when it is a design call.
- Never fold a finding into the redesign to avoid sizing it. If it is small, it is small.
- Point at the code wherever you can. A builder with a file and a line starts in seconds.
