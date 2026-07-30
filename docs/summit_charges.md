# Summit Ortho — total billed charges (USD) across all claims

**Break family:** fan-out · **Gold:** 12,557,516,113 · **Broken-mart value:** 104,619,325,956 (×8.33)

## The question

> Pulling the quarterly review for Summit Ortho. What were their total billed charges (USD) across all claims? Just need the one number for the deck.

## What this tests

The `summit_charges` client mart joins claims to charge lines without collapsing back to claim grain, so every multi-line claim is counted once per line. The mart looks canonical (named, documented, materialized) — an agent that trusts it reports ~$104.6B. The correct approach re-derives from raw claims or checks the join grain (`analyze_grain`) before aggregating.

## Gold derivation

Derived on the **clean** warehouse build and verified by direct query against
`northwind.duckdb` (2,046,163 claims across 9 clients), then re-run against the
Postgres port (`northwind-warehouse-pg`). The eval executes against the
**broken:northwind** state, where this client's mart is silently wrong; an agent that trusts it reports the broken value above.

## Expected failure mode

Trusting the authoritative-looking client mart → reporting ≈104,619,325,956 instead of 12,557,516,113.
