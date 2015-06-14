#!/bin/sh

export DB=gismentors

git clone https://github.com/ctu-osgeorel/gdal-vfr.git
cd gdal-vfr

### import dat do schematu ruian
./vfr2pg --type ST_UKSG --dbname $DB --schema ruian --geom GeneralizovaneHranice

### import dat do schematu ruian_praha
./vfr2pg --type OB_554782_UKSH --dbname $DB --schema praha_praha --geom OriginalniHranice

### prejmenovani atributu
# cat vfr.txt | cut -d '|' -f2,3,4 | sed 's/ \+//g' |  awk -F'|' '{printf "alter table "$1"."$2" rename "$3" to geom;\n"}'
psql $DB -f rename.sql
