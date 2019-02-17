#!/bin/sh

DIR=/tmp/aopk
DB=gismentors
SCHEMA=aopk

psql $DB -c "drop schema $SCHEMA cascade"
psql $DB -c "create schema $SCHEMA"

process() {
    to_pg $1
}

to_pg() {
    shp2pgsql -s 5514 -g geom -D -I $1.shp $SCHEMA.$1 | psql $DB
}

cd $DIR
process maloplosna_chranena_uzemi
process velkoplosna_chranena_uzemi
process velkoplosna_chranena_uzemi_zonace

exit 0
