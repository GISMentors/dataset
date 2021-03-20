#!/bin/sh -e

DATA=/mnt/repository/eu-dem/

v.import input=/mnt/repository/gismentors/gpkg/ruian.gpkg layer=staty output=cr
g.region vector=cr
r.in.gdal input=${DATA}/eu_dem_v11_E40N20.TIF out=tile1
r.in.gdal input=${DATA}/eu_dem_v11_E40N30.TIF out=tile2
g.region align=tile1
r.patch input=tile1,tile2 out=dtm


exit 0
