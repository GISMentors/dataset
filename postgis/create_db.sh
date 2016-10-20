#!/bin/sh

# vytvor db
createdb gismentors

# instaluj PostGIS (musi provest superuser)
psql -c "CREATE EXTENSION postgis" gismentors
psql -c "CREATE EXTENSION postgis_topology" gismentors

# stahni definici S-JTSK s transformaci CUZK pro CR, chyba max 1m
./epsg-5514.sh

# import dat z RUIAN
../ruian/import.sh

# import dat z DIBAVOD
../dibavod/download.sh
../dibavod/import.sh

# import dat z CSU
../csu/import.sh

exit 0
# import jizera
wget http://training.gismentors.eu/geodata/postgis/jizera.sql
psql gismentors -f jizera.sql 
rm jizera.sql

# vytvor dump
pg_dump -Fc -b -v -O -x -N public -f gismentors.dump gismentors
###pg_dump -Fp -Z9 -O -x -N public -f gismentors.dump gismentors

exit 0
