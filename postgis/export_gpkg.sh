#!/bin/sh

set -e

DB=gismentors

SCRIPT=`realpath $0`
SCRIPT_PATH=`dirname $SCRIPT`

if [ -n "$1" ]; then
    DIR="$1"
else
    DIR=/tmp/gismentors_gpkg
fi

layers=`sudo psql -U postgres $DB -tA -F'.' -c"select f_table_schema,f_table_name from geometry_columns"`

rm -rf $DIR && mkdir $DIR

for layer in $layers; do
    schema=`echo $layer | cut -d'.' -f1`
    table=`echo $layer | cut -d'.' -f2`
    echo "Exporting $schema.$table..."
    sudo ogr2ogr -append -f 'GPKG' $DIR/${schema}.gpkg -nln $table "PG:dbname=$DB user=postgres" ${schema}.$table
done

exit 0
