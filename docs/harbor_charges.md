# Harbor Health — total billed charges (USD)

**Break family:** dedup (fans downstream joins) · **Gold:** 10,355,678,750 · **Broken-mart value:** 58,554,223,180 (×5.65)

## The question

> What is the total charge amount (USD) on file for Harbor System across all their claims?

## What this tests

Same missing dedup as `harbor_claim_count`, surfacing as a ×5.65 inflated dollar total. The duplicates compound through the charge-line join, so the error is larger than the raw duplicate rate alone would suggest.

## Gold derivation

Derived on the **clean** warehouse build and verified by direct query against
`northwind.duckdb` (2,046,163 claims across 9 clients), then re-run against the
Postgres port (`northwind-warehouse-pg`). The eval executes against the
**broken:northwind** state, where this client's mart is silently wrong; an agent that trusts it reports the broken value above.

## Expected failure mode

Trusting the authoritative-looking client mart → reporting ≈58,554,223,180 instead of 10,355,678,750.
