# Claude Code skills -- four, free, and checked against Anthropic's docs

There are repositories offering three hundred skills. This is four, and the
difference is what happened to them before they were published.

**Every rule here names the failure it prevents.** Not what the skill does -- what goes
wrong without it. If a rule cannot name its failure, it was cut rather than kept.

**Every claim about Claude Code was verified at Anthropic's own documentation, with the
date it was read.** Where a claim could not be verified, the skill says so in the text
instead of stating it anyway. Several widely repeated figures did not survive that check
and are not in here.

**They survive truncation.** After a long conversation compacts, Claude Code re-injects an
invoked skill capped at 5,000 tokens and keeps the *start* of the file -- so a long skill
silently loses its tail in exactly the session it was written for. Each skill here longer
than that opens with a card restating everything load-bearing, so a truncated copy is still
correct. ([the write-up](https://tools.prepbrix.com/skill-stops-working-long-session))

Drop a folder into `~/.claude/skills/` (all projects) or `<repo>/.claude/skills/` (one
project), then invoke it by name or let the agent load it.


- **review-ai-code** -- review AI-generated code like a senior developer: a 9-step
  ordered review + pre-merge checklist that catches bugs that pass the tests but are
  not safe to ship.
- **claude-md-rules** -- write a CLAUDE.md the agent actually follows: a behavioral
  contract of imperative rules, each closing a specific failure mode.
- **context-curation** -- choose the smallest sufficient context per step instead of
  dumping the whole window, so the agent stays sharp and cheap.
- **session-handoff-memory** -- stop the agent starting every session from zero: keep
  a small curated memory file it reads at the start and updates at the end, so it stops
  re-asking what you told it and stops repeating a dead end it already ruled out.

## Field notes -- the reasoning, free to read

Short write-ups of specific failures, each checked against Anthropic's own
documentation or observed directly rather than assumed. No signup.

- [Your skill stops working in long sessions](https://tools.prepbrix.com/skill-stops-working-long-session)
  -- after compaction a skill is re-injected capped at 5,000 tokens, and truncation keeps the START of the file.
- [A CLAUDE.md rule that worked and then stopped](https://tools.prepbrix.com/claude-md-rule-stopped-applying)
  -- path-scoped rules do not survive compaction. The project-root file does.
- [Why Claude ignores your CLAUDE.md](https://tools.prepbrix.com/claude-md-ignored)
  -- four reasons a rule does not hold, a scope-gap test, and a drift canary.
- [Your agent agrees with everything you say](https://tools.prepbrix.com/agent-agrees-with-everything)
  -- why a coding agent validates a bad plan, and how to get a real judgment.
- [Your scheduled task says it succeeded and did nothing](https://tools.prepbrix.com/scheduled-task-ran-but-did-nothing)
  -- a run that produces no output is not missing, not stuck and not failed.
- [Your cron job fired on the wrong day](https://tools.prepbrix.com/cron-fired-on-the-wrong-day)
  -- day-of-month and day-of-week are OR-ed, plus dispatch offsets and catch-up runs.
- [Your agent stalled and you lost the work](https://tools.prepbrix.com/agent-stalled-lost-the-work)
  -- you probably did not. Flush per item, then finish from the file.
- [Auto mode: what actually changed](https://tools.prepbrix.com/auto-mode-what-changed)
  -- the permission mode that now starts by default, and which allow rules it drops.

## Related

These four are complete and free to use. Three of them also appear in a larger paid set
of eight, which adds adversarial-self-critique, self-verifying-loops,
multi-agent-finisher, agent-bash-security and skill-authoring. It is mentioned here for
disclosure rather than as an ask -- nothing in this repository depends on it, and the
four skills above are not samples that stop working.
[Details](https://tools.prepbrix.com).

*Not affiliated with Anthropic. "Claude" is a trademark of Anthropic.*
