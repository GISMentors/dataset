#!/usr/bin/python

# TODO: parse EPSG code

from __future__ import print_function
import os
import sys
import subprocess
import psycopg2

def main(db, epgs):
    for mapset in Location().mapsets():
        create_schema(db, mapset.lower())
        export_vect(mapset, db, epsg)
        export_rast(mapset, db, epsg)

def create_schema(db, schema):
    conn_string = "dbname={}".format(db)
    try:
        conn = psycopg2.connect(conn_string)
    except psycopg2.OperationalError as e:
        sys.exit("Unable to connect to DB: %s\nTry to define --user and/or --passwd" % e)
    
    cursor = conn.cursor()
    try:
        cursor.execute("SELECT schema_name FROM information_schema.schemata "
                        "WHERE schema_name = '%s'" % schema)
        if not bool(cursor.fetchall()):
            # cursor.execute("CREATE SCHEMA IF NOT EXISTS %s" % schema)
            cursor.execute("CREATE SCHEMA %s" % schema)
            conn.commit()
    except StandardError as e:
        sys.exit("Unable to create schema %s: %s" % (schema, e))
    
    cursor.close()
    conn.close()

def export_rast(mapset, db, epsg):
    for rast in Mapset(mapset).glist('raster'):
        print("Exporting RASTER <{}> ({})...".format(rast, mapset), file=sys.stderr)
        out = os.path.join('/', 'tmp', '{}_{}'.format(rast, str(os.getpid())))
        Module('g.region', raster=rast)
        Module('r.out.gdal', flags='f', input=rast, output='{}.tif'.format(out), type='UInt16',
               overwrite=True)
        r2pg = subprocess.Popen(['raster2pgsql', '-s', epsg, '-C', '-d', '-t', '400x400',
                                 '-I', '-Y', '{}.tif'.format(out), '{}.{}'.format(mapset, rast)],
                                 stdout = subprocess.PIPE)
        pg = subprocess.Popen(['psql', db], stdin = r2pg.stdout)
        pg.communicate()
        os.remove('{}.tif'.format(out))
                  
def export_vect(mapset, db, epsg):
    for vect in Mapset(mapset).glist('vector'):
        print("Exporting VECTOR <{}> ({})...".format(vect, mapset), file=sys.stderr)
        # Module('v.out.postgis', input=vect, output="PG:dbname=pgis_student",
        #        output_layer='%s.%s' % (mapset, vect),
        #        options="srid=5514", overwrite=True)
        Module('v.out.ogr', input='{}@{}'.format(vect, mapset), output="PG:dbname={}".format(db),
               output_layer='%s.%s' % (mapset, vect),
               overwrite=True, format='PostgreSQL', lco='GEOMETRY_NAME=geom',
               flags='m')
        
if __name__ == "__main__":
    # output - PostGIS
    db = 'gismentors'
    # input - GRASS
    gisdb = os.path.join(os.environ['HOME'], 'smetiste')
    location = 'gismentors'
    mapset = 'PERMANENT'
    epsg = '5514'
    
    # initialize GRASS
    os.environ['GISBASE'] = gisbase = os.path.join(os.environ['HOME'], 'src', 'grass_trunk', 'dist.x86_64-unknown-linux-gnu')
    os.environ['LD_LIBRARY_PATH'] = os.path.join(gisbase, 'lib')
    sys.path.insert(0, os.path.join(gisbase, "etc", "python"))

    # import libraries
    import grass.script.setup as gsetup
    from grass.pygrass.gis import Location, Mapset
    from grass.pygrass.modules import Module

    # set up input location
    gsetup.init(gisbase,
                gisdb, location, mapset)
    
    # do conversion
    sys.exit(main(db, epsg))
