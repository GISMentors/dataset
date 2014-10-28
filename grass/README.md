Vytvoření GRASS lokace
----------------------

        grass70 -c EPSG:5514:3 /opt/grassdata/skoleni

RÚIAN
=====

Import:

        g.mapset -c ruain
        
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
        pass

        export map=zsj_originalnihranice
        v.clean input=$map output=x type=area tool=rmarea thresh=19000 --o
        g.rename vect=x,$map --o
        TODO: nektery ZSJ chybi v RUIANU (zjistit proc)

        export map=okresy_generalizovanehranice
        v.clean input=$map output=x type=area tool=rmarea thresh=200000 --o
        g.rename vect=x,$map --o

        export map=orp_generalizovanehranice
        v.clean input=$map output=x type=area tool=rmarea thresh=45000000 --o
        g.rename vect=x,$map --o

        export map=pou_generalizovanehranice
        v.clean input=$map output=x type=area tool=rmarea thresh=13900000 --o
        g.rename vect=x,$map --o

Test:
        
        export map=obce_generalizovanehranice

        db.select sql="select count(*) from $map"
        v.info -t map=$map
        
        g.copy vect=$map,x --o
        v.db.addcolumn map=x column="pomoc int"
        v.db.update map=x column=pomoc value=1
        v.dissolve input=x output=y column="pomoc" --o
        g.remove -f vect name=x,y
        
Přejmenování vrstev:

        for map in `g.list vect pat='*_*hranice'` ; do g.rename vect=$map,${map%%_*}_polygony ; done
        for map in `g.list vect pat='*_*bod'` ; do g.rename vect=$map,${map%%_*}_body ; done

EU-DEM
======

        g.mapset PERMANENT

OSM
===

        g.mapset -c osm
        
        # viz osm/README.md
        