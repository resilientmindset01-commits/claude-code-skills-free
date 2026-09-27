# review-ai-code -- worked examples

These are illustrations built from the skill's own procedure, on made-up code. They are not a record of anyone's
review and they carry no results. Invoke the skill by name ("use review-ai-code on this diff") before you merge
code a model wrote.

## Example 1 -- an endpoint that passes its tests

**The change.** An agent added a "download invoice" endpoint. The tests are green.

```js
app.get("/invoices/:id/pdf", requireLogin, async (req, res) => {
  const invoice = await db.invoices.findById(req.params.id);
  res.send(await renderPdf(invoice));
});
```

**Walking the 9 steps on it** (the steps that find something here):

- **1. Start with the problem.** The requirement was "a customer can download THEIR invoices". The code downloads
  any invoice.
- **4. Hidden assumptions.** It assumes a logged-in user may read any id. It assumes the invoice exists.
- **5. Security.** Any logged-in user can fetch another customer's invoice by changing the id -- the login check is
  not an ownership check.
- **8. Error handling.** A missing id reaches `renderPdf(null)` and fails with a 500 instead of a 404.

**After review:**

```js
app.get("/invoices/:id/pdf", requireLogin, async (req, res) => {
  const invoice = await db.invoices.findOne({ id: req.params.id, customerId: req.user.customerId });
  if (!invoice) return res.status(404).send("Not found");
  res.send(await renderPdf(invoice));
});
```

Plus one test that the code did not have: a second customer requesting the first customer's invoice gets a 404.

## Example 2 -- the green run that hides a bug

**The change.** A pricing function and its test changed in the same diff:

```diff
- expect(applyDiscount(100, 0.1)).toBe(90);
+ expect(applyDiscount(100, 0.1)).toBe(99.9);
```

**The check the skill asks for every time:** were the tests changed in the same diff as the code they cover? Here
they were, and the new expected value matches the new (wrong) behaviour: the function now subtracts 0.1 instead of
10 percent. The suite is green because the test was edited to agree with the bug.

**What to do:** read the test change as a claim about the requirement. Ask what the discount was supposed to be,
restore the test that states it, and fix the code, not the test.

## Example 3 -- the pre-merge checklist, filled in

```
REQUIREMENT  customer downloads own invoices only -- fixed (ownership in the query)
DECISIONS    PDF rendered per request, no cache -- fine at current volume, note it
LOGIC        missing id -> 404; traced
SECURITY     ownership check added; ids are treated as guessable
TESTS        added cross-customer test; no test was edited to match code
FOOTPRINT    none new
```

A smaller change that is fully understood beats a larger one that merely passes.
