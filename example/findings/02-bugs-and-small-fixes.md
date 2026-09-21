# Bugs, fixes and small changes from the example session — the complete list

**What this is (plain English):** everything the staged session turned up that is not the redesign in file 01, sized, routed and cited, so a second agent can work down it. The code is `../interface/index.html`; line numbers are real.

**Key.** Size: **S** under half a day · **M** half a day to two days, or needs a decision · **L** a week or more, or part of the redesign. State: ✅ fixed · 🔧 open · 🔍 verify first · ⚖️ needs a decision (who). Route: **now** · **next** · **later**.

---

## 1. Already fixed

None. This is the first pass.

## 2. Small — copy, labels, defaults, one-file fixes (S)

| # | What | Evidence | Where | Size | State | Route |
|---|---|---|---|---|---|---|
| S1 | **"Backlog" means "stuck" to an account manager** — "To me backlog sounds like things that are stuck. Not my work." Rename to **To start** (nav and page title). | Priya 0:17–0:27 (`P-0022`) | `interface/index.html:43` | S | 🔧 | now |
| S2 | **The card's `2/4` has no unit** — "Two of four what? Steps? Documents?" Label it **Set-up 2 of 4**, or show the four steps on hover. | Priya 0:31–0:42 (`P-0038`) | `interface/index.html:60` | S | ⚖️ what it counts — product owner, 01 §4.1 | now |
| S3 | **"1 to acknowledge" is not understood** — "Acknowledge what? Is that me?" Plain words that say what and who, e.g. **1 check needs your reason**. | Priya 0:47–1:05 (`P-0104`) | `interface/index.html:60`, `:66` | S | ⚖️ who acknowledges — 01 §4.2 | now |
| S4 | **Start job gives no confirmation** — the screen is unchanged for three seconds, then the button greys: "Did it take? It looks exactly the same. I was about to press it again." Disable the button on click, show **Started · 10:14** in its place, and change the page state at once. | Priya 1:09–1:24 (`P-0113`, `P-0117`) | `interface/index.html:82` | S | 🔧 | now |
| S5 | **Target date defaults to a date in the past** — "first of September. That's already gone." Rule: never before today; if the derived date is past, default to today or leave blank. | Priya 1:50–1:56 (`P-0152`) | `interface/index.html:73` | S | 🔧 | now |
| S6 | **The second date field has no label** — "Thirty-first of March... is that the deadline, or the year end, or...?" Label it once its meaning is decided. | Priya 1:56–2:04 (`P-0200`) | `interface/index.html:74` | S | ⚖️ what it is — 01 §4.3 | now |

## 3. Medium (M)

None from one session.

## 4. Large, or belongs to the redesign

| # | What | Evidence | Where |
|---|---|---|---|
| L1 | A **Today** view that answers "what do I do today", so the paper notebook can retire. One participant; test before building. | Priya 1:30–1:46 (no frame: spoken, nothing on screen) | 01 §3 |

## 5. Technical failures and demo glitches

None. The demo held up for the whole session.
