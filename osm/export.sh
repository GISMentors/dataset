#!/bin/sh

FILE=/tmp/osm.gpkg
DB=pgis_osm
SCHEMA=gismentors

rm -rf $FILE
ogr2ogr -f GPKG $FILE "PG:dbname=$DB active_schema=$SCHEMA" silnice -overwrite
ogr2ogr -f GPKG $FILE "PG:dbname=$DB active_schema=$SCHEMA" zeleznice -overwrite
ogr2ogr -f GPKG $FILE "PG:dbname=$DB active_schema=$SCHEMA" pozarni_stanice -overwrite

exit 0
