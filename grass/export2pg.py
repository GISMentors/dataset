#!/usr/bin/python

import sys

from grass.pygrass.gis import Location, Mapset
from grass.pygrass.modules import Module

for mapset in Location().mapsets():
    if mapset not in ('ruian', 'ruian_praha'):
        continue
    for vect in Mapset(mapset).glist('vector'):
        print >> sys.stderr, "Exporting <%s> (%s)..." % (vect, mapset)
        Module('v.out.postgis', input=vect, output="PG:dbname=pgis_student",
               output_layer='%s.%s' % (mapset, vect),
               options="srid=5514", overwrite=True)
        # Module('v.out.ogr', input=vect, output="PG:dbname=pgis_student",
        #        output_layer='%s.%s' % (mapset, vect),
        #        overwrite=True, format='PostgreSQL', lco='GEOMETRY_NAME=geom')

sys.exit(0)
