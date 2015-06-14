#!/bin/sh

./grass.sh
raster2pgsql -s 5514 -Y -C -t 400x400 /tmp/dmt.tif rastry.dmt | psql gismentors

exit 0
