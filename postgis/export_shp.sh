#!/bin/sh

set -e

DB=gismentors

SCRIPT=`realpath $0`
SCRIPT_PATH=`dirname $SCRIPT`

if [ -n "$1" ]; then
    DIR="$1"
else
    DIR=/tmp/gismentors_shp
fi

layers=`sudo psql -U postgres $DB -tA -F'.' -c"select f_table_schema,f_table_name from geometry_columns"`

rm -rf $DIR && mkdir $DIR

for layer in $layers; do
    schema=`echo $layer | cut -d'.' -f1`
    table=`echo $layer | cut -d'.' -f2`
    if [ ! -d $DIR/$schema ] ; then
        cd $DIR
        mkdir $schema
        cd $schema
    fi
    echo "Exporting $schema.$table..."
    sudo ogr2ogr -f 'ESRI Shapefile' -lco 'ENCODING=UTF-8' -lco 'RESIZE=YES' ${table}.shp "PG:dbname=$DB user=postgres" ${schema}.$table
    sudo cp $SCRIPT_PATH/epsg-5514.qpj ${table}.qpj
done

exit 0
