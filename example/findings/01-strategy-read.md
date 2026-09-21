# Client set-up — what the session showed, and what to build

**What this is (plain English):** the strategy read for the staged example session (Priya Nair, account manager, fictional; 21 Sep 2026, 1:52 on the recording). One participant, one flow: taking a new client, Willow & Finch Studio, through set-up in the Practice Desk demo. Every claim carries the quote, the time and the frame. Frames are in `../sessions/2026-09-21-1000-priya-nair/frames/`.

**Status:** analysis of one staged session. Nothing here is decided; §4 lists what needs a ruling. With one participant, every count below is "one of one" and should be read that way.

---

## 1. What the session said

| Person | What they actually run their day from | What the product is for them | Frames |
|---|---|---|---|
| **Priya** (account manager) | A paper notebook, one page a day: "The task list in our current system is so long that I stopped looking at it, so I write the client and what I'm chasing in the notebook, on the day I'll do it" (1:30–1:46; nothing on screen for this, no frame) | A record to update after the fact: she completed the set-up task in the demo but planned the chase in the notebook, "Willow and Finch, bank details, for Thursday" (1:30–1:46) | — |

The pattern, in one participant: the real plan lives outside the product; the product is where the record goes. She did every step asked of her, and at four of them she stopped to ask what a word meant.

### 1.1 What is wrong, in her words

- **The nav label does not say what is behind it.** "Or is it this 'Backlog' thing? To me backlog sounds like things that are stuck. Not my work." (Priya 0:17–0:27, `P-0022`). She hovered Backlog for eleven seconds before trying it (recording 0:05–0:18, contact sheet cells 0:10 and 0:20).
- **The card's fraction has no unit.** "This says two of four. Two of four what? Steps? Documents? I'd want it to say." (Priya 0:31–0:42, `P-0038`). Asked what she expected: "Probably how far along they are. But I'm guessing." (0:47).
- **"1 to acknowledge" is a system word.** "Acknowledge what? Is that me? I don't know what it's asking me to do." (Priya 0:47–1:05, `P-0104`).
- **Starting a job gives no sign it worked.** "Did it take? It looks exactly the same. I was about to press it again." (Priya 1:09–1:24). `P-0113` shows the screen one second after the click, unchanged; `P-0117` shows the button greyed four seconds later and nothing else. She read the grey as the confirmation: "Oh, the button's gone grey. So it did. A little 'started' would help."
- **The target date defaults to a date already gone.** "Target date, first of September. That's already gone. So is that when it's due, or when I should start?" (Priya 1:50–1:56, `P-0152`). The session was on 21 September; the field said 01 Sep 2026.
- **A date with no label.** "This one underneath has no label at all. Thirty-first of March... is that the deadline, or the year end, or...?" (Priya 1:56–2:04, `P-0200`).

### 1.2 What she liked

- The checklist on the client page read without help: "ID check done, engagement letter done, bank details, previous accountant" (0:47–1:00, `P-0104`). It is the only element she narrated without a question.

## 2. The diagnosis

- **The labels use the builder's vocabulary.** Backlog, 2/4, acknowledge: each is a word or a count that means something to whoever built the screen and nothing to the person using it. Three of the six problems are this one problem.
- **Actions do not answer back.** Start job changes state silently and, three seconds later, greys the button. The gap is long enough for a second press, which is the say/do moment of the session: she said "did it take?" while her cursor stayed on the button (`P-0113`).
- **Defaults are computed without a floor.** A target date derived from something upstream landed in the past. Whatever the rule, "never before today" is missing.
- **Say versus do.** She *said* she would go to Clients (0:17) and *did* go to Backlog (0:33). The words were the expectation; the click was a guess. Believe the click: the client she wanted was on the Clients page too (`P-0022` shows it, last row), and she never looked there.

## 3. What to build

**Smallest change that answers §2** (all in `02-bugs-and-small-fixes.md`, sized S): rename Backlog to *To start*; label the fraction *Set-up 2 of 4*; replace "1 to acknowledge" with words that say what and who; give Start job an immediate state change and a line that says *Started*; floor the target date at today; label the second date.

**The fuller change, if the pattern holds across more participants:** a *Today* view that answers "what do I do today", so the notebook has a reason to retire. One participant is not enough to build it on. Test it next.

## 4. What needs a decision

1. **What does the fraction count?** Set-up steps, documents received, or checks passed. The label depends on the answer. (Evidence: 0:31–0:47, `P-0038`.)
2. **Who acknowledges, and what?** If it is the account manager, say so in the chip; if it is a reviewer, the chip should not be on her card at all. (0:47–1:05, `P-0104`.)
3. **What is the second date?** Deadline, year end or something else; it needs a name before it needs a label. (1:56–2:04, `P-0200`.)

## 5. What we did not learn

- One participant. Every finding here is "one of one"; the strategy read earns its name with five.
- The demo has no Jobs list, so we did not see what she expects after Start job beyond the button.
- No audio on the staged recording; the say/do reading leans on the transcript alone for the words. Real sessions have both.
