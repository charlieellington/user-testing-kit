# Prompt 00 — a real interface with dummy data

Use this before the sessions. The goal is a copy of the real product that behaves exactly like the real thing, loaded with fictional data, that a participant can use with no risk to real records. Test the real thing with fictional data, never a mock-up: people behave differently in front of a prototype, and a prototype hides the bugs.

## The prompt

Open your coding agent in the product's repo, on a branch, and ask:

> Create a real deployment of our [onboarding] interface and user flows with dummy data, off our real database, that interacts exactly like the real thing, that I can use for testing.

Then be specific about what you need:

- **Isolation.** A branch of the code and a branch or copy of the database. Nothing the participant does can touch production records.
- **Fictional cases.** Three to five starting points that cover the states you want to test: a brand-new case, one in progress, one stuck, one finished. Give each a fictional name and a one-line story. Keep the list; the names will appear in your findings.
- **A facilitator page.** One page that lists the cases as task cards, with an "open" link for each and a **reset** button that restores the starting state. You reset between participants.
- **Hosted, one login.** A stable URL and one test account. Write the credentials somewhere private, never in the repo.
- **Nothing extra.** Do not add features to make the test look complete. If a flow ends at a wall, the wall is a finding.

## Before the first session

- Run through every case yourself, once, then reset it.
- Check what a participant sees if they wander: other screens, real data, admin pages. Close any door that leads to something real.
- Decide the tasks. One at a time, in the participant's own words, without leading: "Willow & Finch have just signed. Take them through set-up."

## In the session

Ask consent to record and say what the recording is for. Say it is a test of the interface, not of them. Have them share the whole screen, press record, and let them think aloud. When they pause: "What are you looking for?" or "What would you expect to happen?" Do not help until they are truly stuck, and note the moment you did, because that moment is a finding too.
