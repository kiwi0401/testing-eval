# Org-wide — total charges billed to Medicare

**Break family:** payer xref (compound) · **Gold:** 5,668,552,527 · **Broken-mart value:** 10,251,121,814 (×1.81)

## The question

> Across the whole org, what were the total billed charges (USD) for claims where the payer is Medicare?

## What this tests

The only org-level question. `fct_org_denial_rate_by_payer` unions the fanned summit + harbor claims AND drops the payer cross-reference, so three breaks compound into a ×1.81 error. Tests whether the agent re-derives org rollups from client-level reconciled numbers instead of trusting the org mart.

## Gold derivation

Derived on the **clean** warehouse build and verified by direct query against
`northwind.duckdb` (2,046,163 claims across 9 clients), then re-run against the
Postgres port (`northwind-warehouse-pg`). The eval executes against the
**broken:northwind** state, where this client's mart is silently wrong; an agent that trusts it reports the broken value above.

## Expected failure mode

Trusting the authoritative-looking client mart → reporting ≈10,251,121,814 instead of 5,668,552,527.
