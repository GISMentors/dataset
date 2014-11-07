Příprava dat OSM
================

Vytvoření geodatabáze na základě dat OSM
----------------------------------------

        export DB=pgis_osm
        export SCHEMA=gismentors
        
        createdb $DB || (dropdb $DB && createdb $DB) && psql $DB -c"create extension postgis"

        wget http://download.geofabrik.de/openstreetmap/europe/czech-republic-latest.osm.bz2
                
        osm2pgsql -d $DB -p czech -s czech-republic-latest.osm.bz2

Přidání vrstvy 'stat' z RÚIAN
-----------------------------

        ogr2ogr -f PostgreSQL "PG:dbname=$DB active_schema=$SCHEMA" ruan_cr.gpkg staty_generalizovanehranice

Export tématických vrstev do GeoPackage
---------------------------------------
