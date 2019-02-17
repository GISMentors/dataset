#!/bin/sh

set -e

DIR=/tmp/dibavod
DB=gismentors
SCHEMA=dibavod

psql $DB -c "drop schema if exists $SCHEMA cascade"
psql $DB -c "create schema $SCHEMA"

process() {
    to_pg $1
}

to_pg() {
    shp2pgsql -s 5514 -g geom -D -I -W cp1250 $1.shp $SCHEMA.$1 | psql $DB
}

cd $DIR
process vodni_toky
process vodni_nadrze
process povodi_iv
process povodi_iii
process povodi_ii
process povodi_i

process zaplava_5
process zaplava_20
process zaplava_100
process zaplava_max

exit 0
