#!/bin/sh

#vytvor db
createdb gismentors;

#instaluj postgis (musi provest superuser)
psql -c "CREATE EXTENSION postgis" gismentors;
psql -c "CREATE EXTENSION postgis_topology" gismentors;

#stahni definici S-JTSK s transformaci CUZK pro CR, chyba max 1m
wget http://epsg.io/5514-1623.sql > /dev/null

#nahraj 5514 do db
psql -f 5514-1623.sql gismentors
rm 5514-1623.sql

#import dat z RUIAN
../ruian/import.sh

#import dat z DIBAVOD
../dibavod/import.sh

#import dat z CSU
../csu/import.sh

#vytvořit dump
pg_dump -Fp -Z9 -O -x -N public -f gismentors.dump gismentors

exit 0
