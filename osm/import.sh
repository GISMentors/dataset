#!/bin/sh

set -e

DB=gismentors

SCRIPT=`realpath $0`
SCRIPT_PATH=`dirname $SCRIPT`

osm2pgsql -d $DB -p osm -E 3857 -C 8000 -S ${SCRIPT_PATH}/default.style /tmp/czech-republic-latest.osm.bz2

psql $DB -f ${SCRIPT_PATH}/pozarni_stanice.sql
psql $DB -f ${SCRIPT_PATH}/silnice.sql
psql $DB -f ${SCRIPT_PATH}/zeleznice.sql
psql $DB -f ${SCRIPT_PATH}/cleanup.sql

rm /tmp/czech-republic-latest.osm.bz2

exit 0
