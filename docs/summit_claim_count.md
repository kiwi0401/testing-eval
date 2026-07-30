# Summit Ortho — distinct claim count

**Break family:** fan-out · **Gold:** 360,618 · **Broken-mart value:** 2,346,956 (×6.51)

## The question

> Quick one for Summit Ortho — how many claims do we have for them in total? Finance wants the claim volume.

## What this tests

Same fanned mart as `summit_charges`: counting rows instead of `COUNT(DISTINCT claim_id)` inflates the count ×6.5. The gold is the distinct claim count on the clean build.

## Gold derivation

Derived on the **clean** warehouse build and verified by direct query against
`northwind.duckdb` (2,046,163 claims across 9 clients), then re-run against the
Postgres port (`northwind-warehouse-pg`). The eval executes against the
**broken:northwind** state, where this client's mart is silently wrong; an agent that trusts it reports the broken value above.

## Expected failure mode

Trusting the authoritative-looking client mart → reporting ≈2,346,956 instead of 360,618.
