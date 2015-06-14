#!/bin/sh

### grass70 /work/geodata/grassdata/gismentors/user1/
g.region rast=dmt res=100 -a
r.resamp.interp in=dmt out=dmt100
r.out.gdal in=dmt100 out=/tmp/dmt.tif type=UInt16 --o -f

