# Metro General — count of discharges dated before admission

**Break family:** dirty-row clamp · **Gold:** 3,649 · **Broken-mart value:** 0 (→0)

## The question

> Data quality flag for Metro Childrens — how many of their encounters have a discharge date earlier than the admit date? Need the count.

## What this tests

A data-quality question: the broken mart *clamps* negative lengths of stay to zero, so the mart reports 0 such rows. The raw data has 3,649. An agent that only reads the mart confidently reports the wrong answer to a question about dirty data itself.

## Gold derivation

Derived on the **clean** warehouse build and verified by direct query against
`northwind.duckdb` (2,046,163 claims across 9 clients), then re-run against the
Postgres port (`northwind-warehouse-pg`). The eval executes against the
**broken:northwind** state, where this client's mart is silently wrong; an agent that trusts it reports the broken value above.

## Expected failure mode

Trusting the authoritative-looking client mart → reporting ≈0 instead of 3,649.
