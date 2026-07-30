# Northwind eval set

Graded questions for the **Northwind (eval)** demo warehouse in SignalPilot.

14 questions: 10 that probe silent data-quality defects, and 4 controls that
should pass regardless (2 warehouse controls, 2 harness controls that fail
loudly if the sandbox or MCP wiring is broken).

## What it is testing

The Northwind marts sit at **service-line grain**, not claim grain. A naive
aggregate over `marts.fct_org_claims` therefore over-counts — roughly 6× on the
clients involved — while `count(distinct claim_id)` is exact. The eval asks for
totals in plain business language and grades the number. An agent that trusts
the mart's shape reports a figure several times too large; one that checks the
grain first does not.

Charges are inflated; counts are not. That asymmetry is deliberate — it means a
run cannot pass by being uniformly suspicious of every number.

## Using it

On the SignalPilot **Evals** page set the eval repo to this repository, and set
the eval connection to the **Northwind (eval)** warehouse added from `/demo-db`.

The warehouse ships already in the `broken` state, so no setup script runs — the
state name in `eval.json` is only a grouping label.

Pin the run to the eval connection. If the workspace also holds a clean copy of
this warehouse, an unpinned run can read the answer off the clean copy and the
grade means nothing.

## Layout

```
eval.json        # the index: metadata + all 14 questions, with gold values
prompts/<id>.txt # the question as a person would ask it
docs/<id>.md     # writeup rendered on the /evals page
```

`eval.json` carries the gold values. Treat this repository as an answer key:
do not hand it to the agent being graded.
