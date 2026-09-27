# session-handoff-memory -- worked examples

These are illustrations built from the skill's own procedure, on a made-up project. They are not a record of
anyone's session and they carry no results. Invoke the skill by name ("use session-handoff-memory to close this
session") at the end of a working session.

## Example 1 -- setting it up

Add one line to the project's CLAUDE.md so the file loads every session without you asking:

```
Read MEMORY.md first and follow it.
```

Create `MEMORY.md` with the four buckets, empty:

```
# MEMORY
## Decisions
## Conventions
## Dead ends
## Open threads
```

## Example 2 -- closing a session

**What happened in the session:** you chose Postgres over MongoDB, the agent tried server-side rendering for the
dashboard and it failed on the auth cookie, the payment webhook is half-done, and the test suite was red for an hour
before a typo was fixed.

**What goes in MEMORY.md** -- one line per fact, each true next week and not already in git:

```
## Decisions
- Postgres, not MongoDB: the data is relational and reports need joins.
## Conventions
- Use the shared <Button> component, never a raw <button>.
## Dead ends
- SSR for the dashboard: abandoned, the auth cookie is not available at render time.
## Open threads
- Payment webhook verifies the signature but does not handle refunds. Next: add the refund branch.
```

**What stays out:** "the tests were red" (ephemeral, and fixed), the list of files changed (git records it), the
transcript, and the webhook signing secret (memory files get committed and shared).

## Example 3 -- pruning the next week

A week later the refund branch is done and you moved the dashboard to client-side rendering. Update, do not append:

```
## Decisions
- Postgres, not MongoDB: the data is relational and reports need joins.
- Dashboard renders client-side: SSR could not read the auth cookie.
## Open threads
(none)
```

The dead end became a decision, the finished thread was deleted, and the file stayed short enough to read in full at
the start of every session.
