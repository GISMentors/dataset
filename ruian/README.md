Příprava dat RUIAN
==================

Vytvoření geodatabáze na základě dat RUIAN
------------------------------------------

        export DB=vfr_uksg
        
        createdb $DB || (dropdb $DB && createdb $DB) && psql $DB -c"create extension postgis"
        
        git clone git@github.com:landam/ogr-vfr.git
        cd ogr-vfr
        
        nohup ./vfr2pg --file test_suite/db_uksg.txt --dbname $DB >log.txt 2>log_err.txt &

Export do GeoPackage
--------------------

        ./pg2ogr --dbname $DB --dsn /tmp/$DB.gpkg --format GPKG --o

Odkaz na předgenerovaná data
----------------------------

* http://geo102.fsv.cvut.cz/~landa/geodata/ruian/
