Příprava dat RÚIAN
==================

Vytvoření geodatabáze na základě dat RÚIAN
------------------------------------------

        export DB=vfr
        
        createdb $DB || (dropdb $DB && createdb $DB) && psql $DB -c"create extension postgis"
        
        git clone git@github.com:landam/ogr-vfr.git
        cd ogr-vfr
        
Import ST_UKSG do schematu 'uksg'
---------------------------------

        ./vfr2pg --file test_suite/db_uksg.txt --dbname $DB --schema uksg

Import OB_554782_UKSH do schematu 'praha'
-----------------------------------------

        ./vfr2pg --type OB_554782_UKSH         --dbname $DB --schema praha

Export do GeoPackage
--------------------

        ./pg2ogr --dbname $DB --schema uksg  --dsn ruian_cr.gpkg    --format GPKG --o
        ./pg2ogr --dbname $DB --schema praha --dsn ruian_praha.gpkg --format GPKG --o

Odkaz na předgenerovaná data
----------------------------

* http://46.28.111.140/gismentors/skoleni/geodata/ruian/
