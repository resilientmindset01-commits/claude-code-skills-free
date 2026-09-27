# claude-md-rules -- worked examples

These are illustrations built from the skill's own procedure, on a made-up project. They are not a record of
anyone's session and they carry no results. Invoke the skill by name ("use claude-md-rules to audit my
CLAUDE.md") or let the agent load it when you ask for a CLAUDE.md review.

## Example 1 -- the prohibition audit on an existing file

**Starting point.** A CLAUDE.md that has grown one rule per incident:

```
NEVER modify files outside src/.
Don't use any.
IMPORTANT: DO NOT skip tests!!!
Never copy whole files between environments.
Always use the edit tool for targeted changes.
Be careful with the database.
```

**What the skill has you do**, in order:

1. Grep for `never`, `don't`, `do not`, `avoid`, `stop`. For each hit, ask what the agent should do INSTEAD at that
   moment.
2. Rewrite each one you can answer as "when X, do Y" and delete the prohibition.
3. Keep a prohibition only where the alternative really is "stop and ask", and say exactly that.
4. Cut every rule whose mistake you cannot name. "Be careful with the database" names no mistake, so it goes.
5. Drop the capitals and exclamation marks: shouting repeats the forbidden thing and adds no mechanism.

**After:**

```
When a change needs a file outside src/, stop and ask before editing it.
When a type is unknown, write `unknown` and narrow it; do not use `any`.
Before reporting a task done, run `npm test` and paste the last 5 lines of output.
When a migration touches a table with data, write the down-migration in the same change.
```

## Example 2 -- the scope-gap test

The two rules "never copy whole files between environments" and "always use the edit tool for targeted changes"
look like they cover copying. Run the scope-gap test on them: name the exact mistake each prevents, then ask which
neighbouring action it misses.

- Mistake prevented: the agent overwrites a config file wholesale when it meant to change one line.
- Neighbouring action not covered: the shell's own copy command (`cp prod.env .env`). Neither rule mentions the
  shell, so that path stays open.

**Rewrite that closes the gap:**

```
When a file must reach another environment, change it with the edit tool, one targeted change at a time.
When a shell command would copy or move a whole file between environments (cp, mv, scp), stop and ask first.
```

## Example 3 -- a positive canary

Add one harmless, distinctive instruction and watch it instead of watching the rules you care about:

```
When you finish a task, end your last message with the word "Checked."
```

If "Checked." stops appearing in a long session, do not debug your other rules yet. First check whether the file is
still reaching the model at all: truncated, summarised away, or outweighed.

## Pre-merge check for your own CLAUDE.md

- Every rule names the mistake it prevents.
- No bare "never X" without the alternative beside it.
- The file is under 200 lines (Anthropic's documented target, per the skill).
- Rules that must hold at turn 200 sit in the project-root file, not in `paths:`-scoped files.

Related field notes: [Why Claude ignores your CLAUDE.md](https://tools.prepbrix.com/claude-md-ignored) and
[A CLAUDE.md rule that worked and then stopped](https://tools.prepbrix.com/claude-md-rule-stopped-applying).
