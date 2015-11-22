#!/bin/sh

#!/bin/sh

DB=gismentors

layers=`psql $DB -tA -F'.' -c"select f_table_schema,f_table_name from geometry_columns order by f_table_schema"`

for layer in $layers; do
    schema=`echo $layer | cut -d'.' -f1`
    table=`echo $layer | cut -d'.' -f2`
    if [ `g.mapsets -l --q | grep -c $schema` -eq 0 ] ; then
        echo "-----------------------------------------------"
        echo "Creating mapset <$schema>..."
        echo "-----------------------------------------------"
        g.mapset -c $schema --q
    fi
    echo "Importing <$schema.$table>..."
    v.in.ogr input="PG:dbname=$DB" output=$table --q
done

exit 0