#!/bin/sh

export DB=gismentors

if [ ! -d gdal-vfr ] ; then
    git clone https://github.com/ctu-osgeorel/gdal-vfr.git
else
    git pull
fi

export DATA_DIR=/tmp
export LOG_DIR=/tmp

### import dat do schematu ruian
./gdal-vfr/vfr2pg --type ST_UKSG --dbname $DB --schema ruian --geom GeneralizovaneHranice

### import dat do schematu ruian_praha
./gdal-vfr/vfr2pg --type OB_554782_UKSH --dbname $DB --schema ruian_praha --geom OriginalniHranice

### prejmenovani atributu
# cat vfr.txt | cut -d '|' -f2,3,4 | sed 's/ \+//g' |  awk -F'|' '{printf "alter table "$1"."$2" rename "$3" to geom;\n"}'
psql $DB -f rename.sql

