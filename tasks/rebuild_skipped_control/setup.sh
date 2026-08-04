#!/bin/sh
# Per-task setup: drop the mart on THIS task's branch so the agent has to
# rebuild it. Runs against the task's own disposable branch, never the shared
# build branch — SP_WAREHOUSE_DSN is branch-scoped.
set -e
psql "$SP_WAREHOUSE_DSN" -v ON_ERROR_STOP=1 -c 'DROP TABLE IF EXISTS marts.fct_org_charges_by_client'
echo "setup($1): dropped marts.fct_org_charges_by_client on this branch"
