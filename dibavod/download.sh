#!/bin/sh

DIR=/tmp/dibavod

rm -rf /tmp/dibavod
mkdir -p $DIR
cd $DIR

# stazeni dat
download() {
    wget http://www.dibavod.cz/download.php?id_souboru=$1 -O $2.zip
}

process() {
    download $1 $2
    unzip_shp $2
    rename_shp $2 $3
}

unzip_shp() {
    echo "unziping ${1}.zip..."
    unzip ${1}.zip
    rm ${1}.zip
}

rename_shp() {
    echo "renaming '${1}' to '${2}'..."
    rename "s/${1}/${2}/g" *
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

exit 0
