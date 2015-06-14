Příprava dat RÚIAN
==================

Vytvoření geodatabáze na základě dat RÚIAN
------------------------------------------

        export DB=gismentors
        
        ### createdb $DB || (dropdb $DB && createdb $DB) && psql $DB -c"create extension postgis"
        
        git clone git@github.com:landam/ogr-vfr.git
        cd ogr-vfr
        
Import ST_UKSG do schematu 'ruian'
---------------------------------

        ./vfr2pg --type ST_UKSG --dbname $DB --schema ruian --geom GeneralizovaneHranice

Import OB_554782_UKSH do schematu 'praha'
-----------------------------------------

        ./vfr2pg --type OB_554782_UKSH --dbname $DB --schema praha_praha --geom OriginalniHranice

Přejmenování sloupců
--------------------

        cat vfr.txt | cut -d '|' -f2,3,4 | sed 's/ \+//g' |  awk -F'|' '{printf "alter table "$1"."$2" rename "$3" to geom;\n"}'

-->

        alter table ruian_praha.momc rename originalnihranice to geom;
        alter table ruian_praha.castiobci rename definicnibod to geom;
        alter table ruian_praha.katastralniuzemi rename originalnihranice to geom;
        alter table ruian_praha.zsj rename originalnihranice to geom;
        alter table ruian_praha.ulice rename definicnicara to geom;
        alter table ruian_praha.parcely rename originalnihranice to geom;
        alter table ruian_praha.stavebniobjekty rename originalnihranice to geom;
        alter table ruian_praha.adresnimista rename adresnibod to geom;
        alter table ruian.staty rename generalizovanehranice to geom;
        alter table ruian.regionysoudrznosti rename generalizovanehranice to geom;
        alter table ruian.kraje rename generalizovanehranice to geom;
        alter table ruian.vusc rename generalizovanehranice to geom;
        alter table ruian.okresy rename generalizovanehranice to geom;
        alter table ruian.orp rename generalizovanehranice to geom;
        alter table ruian.pou rename generalizovanehranice to geom;
        alter table ruian.obce rename generalizovanehranice to geom;
        alter table ruian.spravniobvody rename definicnibod to geom;
        alter table ruian.mop rename definicnibod to geom;
        alter table ruian.momc rename definicnibod to geom;
        alter table ruian.castiobci rename definicnibod to geom;
        alter table ruian.katastralniuzemi rename generalizovanehranice to geom;
        alter table ruian.zsj rename definicnibod to geom;
        alter table ruian_praha.obce rename originalnihranice to geom;
        alter table ruian_praha.spravniobvody rename originalnihranice to geom;
        alter table ruian_praha.mop rename originalnihranice to geom;

Začlenění UIR
-------------

* https://www.czso.cz/csu/rso/prohlizec_uir_zsj
* https://www.czso.cz/documents/11300/18173069/uir131dc.zip/a00193e2-1648-4d92-b16a-f90eeb3646d1

        SHAPE_ENCODING=cp852 ogr2ogr -f PostgreSQL PG:dbname=gismentors . -lco 'SCHEMA=uir_zsj'
 
Export do GeoPackage
--------------------

        ./pg2ogr --dbname $DB --schema uksg  --dsn ruian_cr.gpkg    --format GPKG --o
        ./pg2ogr --dbname $DB --schema praha --dsn ruian_praha.gpkg --format GPKG --o

Odkaz na předgenerovaná data
----------------------------

* http://training.gismentors.eu/gismentors/skoleni/geodata/ruian/
