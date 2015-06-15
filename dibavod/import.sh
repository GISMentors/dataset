#!/bin/sh

cd /tmp

# stazeni dat
download() {
    wget http://www.dibavod.cz/download.php?id_souboru=$1 -O $2.zip
}

process() {
    download $1 $2
}

process 1414 vodni_toky
process 1416 vodni_nadze
process 1418 povodi_iv
process 1419 povodi_iii
process 1420 povodi_ii
process 1421 povodi_i

process 1435 zaplava_5
process 1436 zaplava_20
process 1437 zaplava_100
process 3030 zaplava_max
