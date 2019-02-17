#!/bin/sh

set -e

DIR=/tmp/aopk

rm -rf /tmp/aopk
mkdir -p $DIR
cd $DIR

# stazeni dat
download() {
    wget $1 -O $2.zip
}

process() {
    download $1 $2
    unzip_shp $2
    rename_shp $3 $2
}

unzip_shp() {
    echo "unziping ${1}.zip..."
    unzip -o ${1}.zip
    rm ${1}.zip
}

rename_shp() {
    echo "renaming '${1}' to '${2}'..."
    rename "s/${1}/${2}/g" *
}

# http://gis-aopkcr.opendata.arcgis.com/datasets/
process https://opendata.arcgis.com/datasets/91b1bb5621ae40a58dfddcc4550e147a_2.zip \
        maloplosna_chranena_uzemi Maloplosna_zvlaste_chranena_uzemi

process https://opendata.arcgis.com/datasets/494d6b3749444f74ad4f556f67c2db77_0.zip \
        velkoplosna_chranena_uzemi Velkoplosna_zvlaste_chranena_uzemi

process https://opendata.arcgis.com/datasets/1f82e49b9bf5418a82f076e5f1f7e9cc_1.zip \
        velkoplosna_chranena_uzemi_zonace Zonace_velkoplosnych_zvlaste_chranenych_uzemi

exit 0
