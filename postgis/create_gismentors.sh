#!/bin/sh

#vytvor db
createdb gismentors;

#instaluj postgis (musi provest superuser)
psql -c "CREATE EXTENSION postgis" gismentors;

#stahni definici S-JTSK s transformaci CUZK pro CR, chyba max 1m
wget http://epsg.io/5514-1623.sql >& /dev/null

#nahraj 5514 do db
psql -f 5514-1623.sql gismentors

#smaz
wget http://training.gismentors.eu/geodata/postgis/gismentors.dump >& /dev/null

#stahni dump databaze
wget -xO gismentors.dump >& /dev/null

#nahraj do db
pg_restore gismentors.dump | psql gismentors

#smaz dump
rm -f gismentors.dump

#zdroje optimalizace
# - http://pgtune.leopard.in.ua/
# - http://sourcefreedom.com/tuning-postgresql-9-0-with-pgtune/
# - http://www.linuxexpres.cz/praxe/optimalizace-postgresql
# - http://postgres.cz/wiki/Desatero

exit 0
