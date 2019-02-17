#!/bin/sh

set -e

SCRIPT=`realpath $0`
SCRIPT_PATH=`dirname $SCRIPT`

# vytvor db
createdb gismentors

# instaluj PostGIS (musi provest superuser)
psql -c "CREATE EXTENSION postgis" gismentors
psql -c "CREATE EXTENSION postgis_topology" gismentors

# stahni definici S-JTSK s transformaci CUZK pro CR, chyba max 1m
${SCRIPT_PATH}/epsg-5514.sh

# import dat z RUIAN
${SCRIPT_PATH}/../ruian/import.sh

# import dat z DIBAVOD
${SCRIPT_PATH}/../dibavod/download.sh
${SCRIPT_PATH}/../dibavod/import.sh

# import dat z CSU
${SCRIPT_PATH}/../csu/import.sh

# import dat z OSM
${SCRIPT_PATH}/../osm/download.sh
${SCRIPT_PATH}/../osm/import.sh

# import dat z AOPK
${SCRIPT_PATH}/../aopk/download.sh
${SCRIPT_PATH}/../aopk/import.sh

# import jizera
wget http://training.gismentors.eu/geodata/postgis/jizera.sql
psql gismentors -f jizera.sql 
rm jizera.sql

# vytvor dump
pg_dump -Fc -b -v -O -x -N public -f gismentors.dump gismentors
###pg_dump -Fp -Z9 -O -x -N public -f gismentors.dump gismentors

exit 0
