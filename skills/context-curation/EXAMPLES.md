# context-curation -- worked examples

These are illustrations built from the skill's own procedure, on a made-up project. They are not a record of
anyone's session and they carry no results. Invoke the skill by name ("use context-curation on this task") or let
the agent load it when a long session starts drifting.

## Example 1 -- the agent contradicts a decision it made two hours ago

**Symptom.** In a long refactor session the agent switches the date library back to the one you rejected earlier,
and starts re-reading files it already read.

**The tempting fix:** "use a bigger context window" or "paste the whole history back in". The skill's reversal: a
bigger window DELAYS the problem, it does not solve it.

**What the skill has you do:**

1. Write the decisions down on purpose, outside the conversation, in a short file the agent re-reads:

   ```
   DECISIONS (refactor, 2026-xx-xx)
   - Dates: date-fns, not moment -- moment is being removed from the bundle.
   - API client: keep the existing fetch wrapper; do not add axios.
   STATE
   - Done: src/billing/*. Next: src/reports/*.
   ```

2. Clear stale tool output: the long test logs and file dumps from the first hour are no longer needed.
3. When you compact, protect the decisions and drop the reasoning, not the reverse.
4. For the next step, give the agent only what THAT step needs: the decisions file, the one module being changed,
   and its tests. Put the task last, after the reference material.

## Example 2 -- a retrieval store feeding near-misses

**Symptom.** A support assistant pulls the ten most similar help articles for every question. For "how do I cancel
my annual plan", it retrieves the monthly-plan cancellation article (close in wording, wrong policy) and answers
from it.

**What the skill has you do:** prefer relevance to similarity. Select by the relations that matter here -- which
plan the customer is on, and which article superseded which -- and retrieve few, not many:

```
retrieve(question, filter={"plan": customer.plan, "status": "current"}, top_k=3)
```

Near-misses act as distractors; three right articles beat ten close ones.

## Example 3 -- put the budget in code

Curation you have to remember stops working on the day you are busy. Cap it where it cannot be forgotten:

```
MAX_TOOL_OUTPUT_CHARS = 4000     # truncate long command output before it re-enters the window
MAX_RETRIEVED_DOCS = 3
TOOLS_FOR_TASK = ["read_file", "edit_file", "run_tests"]   # attach only what this task needs
```

And gate before the call: the cheapest model call is the one that does not happen.

## Quick check before a long run

- Are the key decisions in a durable file, not only in the conversation?
- Does each step get the smallest set that answers what THIS step needs?
- Is the task at the end of the prompt, after the long material?
- Are output and retrieval sizes capped in code?

Related field note: [Your skill stops working in long sessions](https://tools.prepbrix.com/skill-stops-working-long-session).
