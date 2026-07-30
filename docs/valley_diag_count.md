# Valley Care — diagnosis record count

**Break family:** version drift · **Gold:** 939,220 · **Broken-mart value:** 312,281 (×0.33)

## The question

> For Valley Care, how many diagnosis records do we have in total across their encounters? Coding team is sizing a review.

## What this tests

Valley's diagnosis extract is pinned to an old code-version filter, dropping two thirds of records (×0.33). The gold counts all diagnosis records on the clean build.

## Gold derivation

Derived on the **clean** warehouse build and verified by direct query against
`northwind.duckdb` (2,046,163 claims across 9 clients), then re-run against the
Postgres port (`northwind-warehouse-pg`). The eval executes against the
**broken:northwind** state, where this client's mart is silently wrong; an agent that trusts it reports the broken value above.

## Expected failure mode

Trusting the authoritative-looking client mart → reporting ≈312,281 instead of 939,220.
