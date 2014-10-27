#!/bin/sh

FILE=/tmp/osm.gpkg
DB=pgis_osm
SCHEMA=gismentors

ogr2ogr -f GPKG  "PG:dbname=$DB" $SCHEMA.vodni_toky

exit 0
