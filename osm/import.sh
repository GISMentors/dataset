#!/bin/sh

DB=gismentors

# osm2pgsql -d $DB -p osm -E 3857 -C 8000 czech-republic-latest.osm.bz2

psql $DB -f pozarni_stanice.sql
psql $DB -f silnice.sql
psql $DB -f zeleznice.sql
psql $DB -f cleanup.sql

exit 0
