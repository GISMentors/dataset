#!/bin/sh

DB=gismentors
DST=/tmp
DIR=$DST/gismentors_shp

layers=`psql $DB -tA -F'.' -c"select f_table_schema,f_table_name from geometry_columns"`

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
    ogr2ogr -f 'ESRI Shapefile' ${table}.shp PG:dbname=$DB ${schema}.$table
done

exit 0