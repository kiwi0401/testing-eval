# Harbor Health — distinct claim count

**Break family:** dedup (fans downstream joins) · **Gold:** 298,455 · **Broken-mart value:** 1,690,572 (×5.66)

## The question

> How many total claims are we carrying for Harbor System? Count each distinct claim once. Trying to reconcile their volume against what they told us.

## What this tests

Harbor's staging layer lost its dedup step, so upstream duplicates fan through every downstream join. The mart's row count is ×5.66 the true claim count. Catching it requires cross-checking against raw claim ids, not the mart.

## Gold derivation

Derived on the **clean** warehouse build and verified by direct query against
`northwind.duckdb` (2,046,163 claims across 9 clients), then re-run against the
Postgres port (`northwind-warehouse-pg`). The eval executes against the
**broken:northwind** state, where this client's mart is silently wrong; an agent that trusts it reports the broken value above.

## Expected failure mode

Trusting the authoritative-looking client mart → reporting ≈1,690,572 instead of 298,455.
