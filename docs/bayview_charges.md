# Bayview Pediatrics — total billed charges (USD) (CONTROL)

**Break family:** none (control) · **Gold:** 7,175,420,145 · **Broken-mart value:** 7,175,420,145 (—)

## The question

> What were Bayview Medical's total billed charges (USD) across all their claims?

## What this tests

Second control: Bayview's marts are correct. The gold equals the mart value exactly.

## Gold derivation

Derived on the **clean** warehouse build and verified by direct query against
`northwind.duckdb` (2,046,163 claims across 9 clients), then re-run against the
Postgres port (`northwind-warehouse-pg`). The eval executes against the
**broken:northwind** state, where this client's subtree is untouched — the mart value is the gold.

## Expected failure mode

None — this is a control. A wrong answer here means the agent is over-skeptical or mis-queried.
