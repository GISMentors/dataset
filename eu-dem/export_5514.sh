#!/bin/sh 

v.import input=/mnt/repository/gismentors/gpkg/ruian.gpkg layer=staty output=cr
g.region vector=cr

# dtm 25m
r.proj location=grassloc-3035 mapset=PERMANENT input=dtm method=bilinear resolution=25
r.colors map=dtm color=elevation
# r.out.gdal input=dtm output=/mnt/repository/eu-dem/dmt.tif type=UInt16 -f

# dmt 100m
g.region res=100 -a
r.mask vector=cr
r.resamp.interp input=dtm output=dtm100 method=bilinea
r.colors map=dtm100 color=elevation
r.out.gdal --overwrite input=dtm100 output=/mnt/repository/eu-dem/dmt100.tif type=UInt16 -f -c # no color table

exit 0
