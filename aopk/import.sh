#!/bin/sh

set -e

DIR=/tmp/aopk
DB=gismentors
SCHEMA=aopk

psql $DB -c "drop schema if exists $SCHEMA cascade"
psql $DB -c "create schema $SCHEMA"

process() {
    to_pg $1
}

to_pg() {
    # shp2pgsql -s 5514 -g geom -D -I $1.shp $SCHEMA.$1 | psql $DB
    ogr2ogr -f PostgreSQL -nln $SCHEMA.$1 -t_srs EPSG:5514 \
            -nlt PROMOTE_TO_MULTI -lco precision=NO -lco geometry_name=geom \
            PG:dbname=$DB $1.shp
}

cd $DIR
process maloplosna_chranena_uzemi
process velkoplosna_chranena_uzemi
process velkoplosna_chranena_uzemi_zonace

exit 0
