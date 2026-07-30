# Metro General — claim denial rate (%)

**Break family:** denial mis-encode · **Gold:** 11.0 · **Broken-mart value:** 40.7 (×3.70)

## The question

> What's the claim denial rate for Metro Childrens? Give me the percentage of their claims that were denied.

## What this tests

The broken build mis-encodes three adjudication status codes as denials, inflating the denial rate from 11.0% to 40.7%. The gold requires checking the status-code mapping against the source system's legend, not trusting the mart's `is_denied` flag.

## Gold derivation

Derived on the **clean** warehouse build and verified by direct query against
`northwind.duckdb` (2,046,163 claims across 9 clients), then re-run against the
Postgres port (`northwind-warehouse-pg`). The eval executes against the
**broken:northwind** state, where this client's mart is silently wrong; an agent that trusts it reports the broken value above.

## Expected failure mode

Trusting the authoritative-looking client mart → reporting ≈40.7 instead of 11.0.
