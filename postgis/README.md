Vytvoření databáze PostGIS
=========================

        createdb gismentors
        psql gismentors -c "create extension postgis"
        psql gismentors -c "create extension postgis_topology"

1) Import dat RUIAN

        ./ruian/import.sh

2) Import dat EU-DEM

   TODO
   
3) Import dat Dibavod

   TODO

4) Import dat CSU

          ./csu/davka_csu.sh

Export
------

        pg_dump -Fc -b -v -O -x -N public -f gismentors.dump gismentors