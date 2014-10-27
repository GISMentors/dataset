Vytvoření GRASS lokace
----------------------

        grass70 -c EPSG:5514:3 /opt/grassdata/skoleni5

Import:

        g.mapset -c ruain
        
        # viz ruian/README.md
        export GFILE=/tmp/$DB.gpkg
        for layer in `v.in.ogr --q dsn=$GFILE -l`; do v.in.ogr dsn=$GFILE layer=$layer ; done

Přejmenování vrstev:

        for map in `g.list vect pat='*_*hranice'` ; do g.rename vect=$map,${map%%_*}_polygony ; done
        for map in `g.list vect pat='*_*bod'` ; do g.rename vect=$map,${map%%_*}_body ; done
