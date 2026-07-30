# Northstar Medical — total billed charges (USD)

**Break family:** schema drift · **Gold:** 8,734,413,028 · **Broken-mart value:** 4,352,587,592 (×0.50)

## The question

> Need Northstar Health's total billed charges (USD) for the annual summary — all claims, whole book.

## What this tests

A renamed source column silently zeroed half of Northstar's charge feed — the mart *undercounts* (×0.50). Deflation traps are nastier than inflation: nothing looks obviously wrong. The tell is reconciling the mart total against the raw landing table.

## Gold derivation

Derived on the **clean** warehouse build and verified by direct query against
`northwind.duckdb` (2,046,163 claims across 9 clients), then re-run against the
Postgres port (`northwind-warehouse-pg`). The eval executes against the
**broken:northwind** state, where this client's mart is silently wrong; an agent that trusts it reports the broken value above.

## Expected failure mode

Trusting the authoritative-looking client mart → reporting ≈4,352,587,592 instead of 8,734,413,028.
