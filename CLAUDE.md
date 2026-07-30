# Project Instructions

## Loaded skills and MCP tools override "be efficient"
When a skill or MCP server is loaded, its instructions are the workflow. Follow every step - do not skip, shortcut, or substitute steps with ad-hoc alternatives to save time. "Output efficiency" means concise *text*, not skipping prescribed tool calls or verification steps. If a skill says to use a specific tool or subagent, use it - do not replace it with a script, CLI command, or manual check.

## Use the tools you have
If an MCP tool or subagent exists for an action (querying, validation, verification), use it. Do not write throwaway scripts or shell commands to do what a provided tool already does. The tools exist because they enforce governance, logging, or correctness guarantees that ad-hoc alternatives bypass.

## Verify grain before you trust ANY number
Before you sum, average, or count a value out of any model, mart, or table, independently verify its grain against the raw source. Compare the table's row count to `count(distinct <grain_key>)`; if they differ, the table fans out — de-duplicate to the true grain before aggregating. Do this every time, for every source, even a "canonical" mart — a published mart can be silently broken by an upstream join. NEVER conclude a number is correct because your query "reconciles" with a mart: if both were built from the same lineage, a shared upstream bug makes them agree while both are wrong. The only figure you may report is one you re-derived at the correct grain from the source data.

## Derive SQL from data, not from descriptions
Task descriptions explain what the data represents. Do NOT translate
description words into SQL predicates, aggregation levels, or deduplication
logic. Query source tables first. Let the data's structure, the YML column
contract, and sibling model patterns determine your SQL. When a description
states explicit transformation rules, implement those rules against the
actual source data.

## Analytics Tasks
Always read the dbt project in this folder for context clues before answering an
analytics question. Do not blindly calculate the answer from the database alone.

Do not treat the modelled layers as authoritative. Staging, intermediate and
marts are all built from a single raw landing table; when a defect sits upstream,
every layer below it agrees with itself while all of them are wrong. Agreement
between a staging table, a fact table and a pre-aggregated summary is therefore
**not** evidence of correctness — it is what a shared upstream bug looks like.
Re-derive from the raw source when the number matters.

Before answering, run search_knowledge probes for the specific entities in
scope — one per source table/entity, plus the connection-scope quirks for each
raw source you will touch, plus the key metric/concept. Use single-keyword
queries (the search is conjunctive — multi-word queries silently return
nothing) and run several. Only answer once those probes are exhausted.

## Trust the YML contract for model names, columns, and materializations
The YML contract defines exact model names, exact column names, and exact materializations. Use the YML name field as the SQL filename. Use the YML materialization as-is. Do NOT add columns beyond what the YML specifies. When sibling models show a YML column is a denormalized value rather than a raw FK, follow the sibling pattern.

## Environment

This folder is our dbt project — the exact build the warehouse was materialised
from. Read the models, the YML contracts and the tests for context; they are the
best evidence of what each column is meant to mean.

dbt itself is **not** wired up here and there are no warehouse credentials on
disk, so do not try to run dbt build or dbt run. All querying goes through the
**SignalPilot** MCP server; the governed connection is named `northwind-eval`
and it is the only connection available to you.

Answer the question and include the actual number in your reply.
