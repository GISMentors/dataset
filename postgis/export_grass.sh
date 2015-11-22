#!/bin/sh

DST=/tmp
DIR=$DST/gismentors_grass

if [ -d $DIR ] ; then
    rm -rf $DIR
fi
export GRASS_BATCH_JOB=../grass/pg_batch_job.sh
grass71 -c EPSG:5514:3 $DIR
unset GRASS_BATCH_JOB

exit 0