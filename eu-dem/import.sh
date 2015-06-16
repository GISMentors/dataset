#!/bin/sh

DB=gismentors
SCHEMA=rastry

./grass.sh
psql $DB -c "drop schema $SCHEMA cascade ; create schema $SCHEMA" 
raster2pgsql -s 5514 -Y -t 400x400 /tmp/dmt.tif $SCHEMA.dmt | psql $DB

exit 0
