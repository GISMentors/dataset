Příprava dat RÚIAN
==================

Vytvoření geodatabáze na základě dat RÚIAN
------------------------------------------

        export DB=vfr_uksg
        
        createdb $DB || (dropdb $DB && createdb $DB) && psql $DB -c"create extension postgis"
        
        git clone git@github.com:landam/ogr-vfr.git
        cd ogr-vfr
        
        nohup ./vfr2pg --file test_suite/db_uksg.txt --dbname $DB >log.txt 2>log_err.txt &

Export do GeoPackage
--------------------

        export GFILE=/tmp/$DB.gpkg
        ./pg2ogr --dbname $DB --dsn /tmp/$DB.gpkg --format GPKG --o

Odkaz na předgenerovaná data
----------------------------

* http://46.28.111.140/gismentors/skoleni/geodata/ruian/

Vytvoření GRASS lokace
----------------------

        grass70 -c EPSG:5514:3 /opt/grassdata/ruian
        for layer in `v.in.ogr --q dsn=$GFILE -l`; do v.in.ogr dsn=$GFILE layer=$layer ; done
