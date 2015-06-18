#!/bin/sh

DIR=/tmp/dibavod
DB=gismentors
SCHEMA=dibavod

#rm -rf /tmp/dibavod
psql $DB -c "drop schema $SCHEMA cascade; create schema $SCHEMA"
mkdir -p $DIR
cd $DIR

# stazeni dat
download() {
    wget http://www.dibavod.cz/download.php?id_souboru=$1 -O $2.zip
}

process() {
    #download $1 $2
    #unzip_shp $2
    to_pg $2 $3
}

unzip_shp() {
    echo "unziping ${1}.zip..."
    unzip ${1}.zip
}

to_pg() {
    shp2pgsql -s 5514 -g geom -D -I -W cp1250 $1.shp $SCHEMA.$2 | psql $DB
}

process 1412 A01_Vodni_tok_CEVT vodni_toky
process 1416 A05_Vodni_nadrze vodni_nadrze
process 1418 A07_Povodi_IV povodi_iv
process 1419 A08_Povodi_III povodi_iii
process 1420 A09_Povodi_II povodi_ii
process 1421 A10_Povodi_I povodi_i

process 1435 D01_ZaplUzemi5Vody zaplava_5
process 1436 D02_ZaplUzemi20Vody zaplava_20
process 1437 D03_ZaplUzemi100Vody zaplava_100
process 3030 D04_ZaplUzemiNejvPrirozPovodne zaplava_max
