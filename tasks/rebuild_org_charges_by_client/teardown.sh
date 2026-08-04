#!/bin/sh
# Teardown runs whether or not the task passed. The branch is destroyed right
# after, so this only reports — it exists to prove teardown is reached.
set -e
psql "$SP_WAREHOUSE_DSN" -v ON_ERROR_STOP=1 -Atc \
  "SELECT 'teardown('||'$1'||'): rows='||count(*) FROM marts.fct_org_charges_by_client" \
  || echo "teardown($1): mart absent at teardown"
