# Riverside Clinic — total billed charges (USD)

**Break family:** money unit · **Gold:** 5,544,542,046 · **Broken-mart value:** 554,454,204,632 (×100)

## The question

> Riverside Health total billed charges (USD), all claims — need it for the client QBR.

## What this tests

Riverside lands charges in cents; the broken mart skips the /100 conversion — a clean ×100 unit error. Magnitude sanity-checking (a single clinic out-billing the rest of the org combined) catches it without any schema knowledge.

## Gold derivation

Derived on the **clean** warehouse build and verified by direct query against
`northwind.duckdb` (2,046,163 claims across 9 clients), then re-run against the
Postgres port (`northwind-warehouse-pg`). The eval executes against the
**broken:northwind** state, where this client's mart is silently wrong; an agent that trusts it reports the broken value above.

## Expected failure mode

Trusting the authoritative-looking client mart → reporting ≈554,454,204,632 instead of 5,544,542,046.
