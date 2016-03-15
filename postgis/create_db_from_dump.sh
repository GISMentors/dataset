#!/bin/sh

DB=gismentors

# vytvorit DB
createdb $DB 2>/dev/null || (dropdb $DB && createdb $DB)

# stahnout dump
wget http://training.gismentors.eu/geodata/postgis/gismentors.dump

# nahrat dump do DB
pg_restore gismentors.dump | psql $DB

# stahnout definici S-JTSK s transformaci CUZK pro CR, chyba max 1m
./epsg-5514.sh $DB

# smazat dump
rm -f gismentors.dump

#zdroje optimalizace
# - http://pgtune.leopard.in.ua/
# - http://sourcefreedom.com/tuning-postgresql-9-0-with-pgtune/
# - http://www.linuxexpres.cz/praxe/optimalizace-postgresql
# - http://postgres.cz/wiki/Desatero

exit 0
