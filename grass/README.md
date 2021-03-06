Vytvoření GRASS lokace
----------------------

        grass70 -c EPSG:5514:3 /opt/grassdata/gismentors

RÚIAN
=====

### ČR

        export GFILE=ruian_cr.gpkg

Import:

        g.mapset -c ruian
        
        # viz ruian/README.md
        export GFILE=/tmp/$DB.gpkg
        for layer in `v.in.ogr --q dsn=$GFILE -l`; do v.in.ogr dsn=$GFILE layer=$layer snap=1 --o; done

Vyčištění topologických chyb:

        export map=obce_generalizovanehranice
        v.clean input=$map output=x type=area tool=rmarea thresh=90000 --o
        g.rename vect=x,$map --o
        # TODO: jedna obec v RUIANu chybi
        
        export map=katastralniuzemi_generalizovanehranice
        v.clean input=$map output=x type=area tool=rmarea thresh=22000 --o
        g.rename vect=x,$map --o

        export map=momc_originalnihranice
        # ?

        export map=zsj_originalnihranice
        v.clean input=$map output=x type=area tool=rmarea thresh=19000 --o
        g.rename vect=x,$map --o
        TODO: nektery ZSJ chybi v RUIANU (zjistit proc...)

        export map=okresy_generalizovanehranice
        v.clean input=$map output=x type=area tool=rmarea thresh=200000 --o
        g.rename vect=x,$map --o

        export map=orp_generalizovanehranice
        v.clean input=$map output=x type=area tool=rmarea thresh=45000000 --o
        g.rename vect=x,$map --o

        export map=pou_generalizovanehranice
        v.clean input=$map output=x type=area tool=rmarea thresh=13900000 --o
        g.rename vect=x,$map --o

Test topologie:
        
        export map=obce_generalizovanehranice

        db.select sql="select count(*) from $map"
        v.info -t map=$map
        
        g.copy vect=$map,x --o
        v.db.addcolumn map=x column="pomoc int"
        v.db.update map=x column=pomoc value=1
        v.dissolve input=x output=y column="pomoc" --o
        g.remove -f vect name=x,y
        
Přejmenování vrstev:

        for map in `g.list vect pat='*_*hranice'` ; do g.rename vect=$map,${map%%_*}_polygon ; done
        for map in `g.list vect pat='*_*bod'` ; do g.rename vect=$map,${map%%_*}_bod ; done
        g.rename vect=staty_bod,stat_bod
        g.rename vect=staty_polygon,stat_polygon

### PRAHA:

        export GFILE=ruian_praha.gpkg

Import:

        g.mapset ruian_praha
        for layer in `v.in.ogr --q dsn=$GFILE -l`; do v.in.ogr dsn=$GFILE layer=$layer snap=1 --o; done
         
Přejmenování vrstev:

        for map in `g.list vect pat='*_*hranice'` ; do g.rename vect=$map,${map%%_*}_polygon ; done
        for map in `g.list vect pat='*_*bod'` ; do g.rename vect=$map,${map%%_*}_bod ; done
        g.rename vect=ulice_definicnicara,ulice

EU-DEM
======

Import:

        grass70 -c EPSG:3035 /opt/grassdata/eu-dem
        
        r.in.gdal input=/vsizip//work/geodata/eu-dem/EUD_CP-DEMS_4500025000-AA.zip/EUD_CP-DEMS_4500025000-AA.tif out=tile1
        r.in.gdal input=/vsizip//work/geodata/eu-dem/EUD_CP-DEMS_4500035000-AA.zip/EUD_CP-DEMS_4500035000-AA.tif out=tile2

        v.proj loc=gismentors mapset=ruian in=stat_polygon
        g.region rast=tile1 vect=stat_polygon -a
        v.proj loc=gismentors mapset=ruian in=stat_polygon
               
        r.out.gdal in=dmt out=~/public_html/geodata/eu-dem/dmt.tif type=UInt16 --o -f
        
Transformace do lokace 'gismentors':

        grass70 /opt/grassdata/gismentors/PERMANENT
        
        g.region n=-846560.70610342 s=-1332801.69195591 w=-998746.18733621 e=-345691.15629692 res=25
        r.mask vector=stat_polygon@ruian
        r.proj input=dmt location=eu-dem mapset=PERMANENT method=bilinear --overwrite
        r.mask -r

OSM
===

        g.mapset -c osm
        
        # viz osm/README.md
        