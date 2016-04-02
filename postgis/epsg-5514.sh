#!/bin/sh

if test -z "$1" ; then
    DB="gismentors"
else
    DB=$1
fi

#stahni definici S-JTSK s transformaci CUZK pro CR, chyba max 1m
wget http://epsg.io/5514-1623.sql > /dev/null

#nahraj 5514 do db
psql -U postgres $DB -c "delete from spatial_ref_sys where srid = 5514"
psql -U postgres $DB -f 5514-1623.sql
rm 5514-1623.sql

exit 0
