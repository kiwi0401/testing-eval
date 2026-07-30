# Cedar Family Practice — distinct claim count (CONTROL)

**Break family:** none (control) · **Gold:** 226,613 · **Broken-mart value:** 226,613 (—)

## The question

> How many total claims do we have for Cedar Clinic?

## What this tests

Control question: Cedar's subtree is clean. Both a trusting and a skeptical agent should land on the same number — this catches over-skeptical agents that second-guess correct marts into wrong answers.

## Gold derivation

Derived on the **clean** warehouse build and verified by direct query against
`northwind.duckdb` (2,046,163 claims across 9 clients), then re-run against the
Postgres port (`northwind-warehouse-pg`). The eval executes against the
**broken:northwind** state, where this client's subtree is untouched — the mart value is the gold.

## Expected failure mode

None — this is a control. A wrong answer here means the agent is over-skeptical or mis-queried.
