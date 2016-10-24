#!/bin/sh

DB=gismentors

if [ -z "$1" ]; then
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
    sudo ogr2ogr -f 'ESRI Shapefile' -lco 'ENCODING=UTF-8' ${table}.shp "PG:dbname=$DB user=postgres" ${schema}.$table
done

exit 0
