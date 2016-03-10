#!/bin/sh

#stahni definici S-JTSK s transformaci CUZK pro CR, chyba max 1m
wget http://epsg.io/5514-1623.sql > /dev/null

#nahraj 5514 do db
sudo psql -U postgres gismentors -c "delete from spatial_ref_sys where srid = 5514"
sudo psql -U postgres gismentors -f 5514-1623.sql
rm 5514-1623.sql

exit 0
