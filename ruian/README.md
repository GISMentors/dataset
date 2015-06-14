Příprava dat RÚIAN
==================

Export do GeoPackage
--------------------

        ./pg2ogr --dbname $DB --schema uksg  --dsn ruian_cr.gpkg    --format GPKG --o
        ./pg2ogr --dbname $DB --schema praha --dsn ruian_praha.gpkg --format GPKG --o

Odkaz na předgenerovaná data
----------------------------

* http://training.gismentors.eu/geodata/ruian/
