#!/bin/sh

#https://www.czso.cz/csu/czso/otevrena_data_pro_vysledky_scitani_lidu_domu_a_bytu_2011_-sldb_2011-

set -e

db=gismentors
schema=csu_sldb

SCRIPT=`realpath $0`
SCRIPT_PATH=`dirname $SCRIPT`

psql -f ${SCRIPT_PATH}/struktura.sql -v schema=${schema} $db;

#iconv -f cp1250 seznam_uzemi\(2\).csv | tail -n +2 | less

cat ${SCRIPT_PATH}/seznam_uzemi.csv |
psql -c "COPY ${schema}.seznam_uzemi FROM STDIN WITH (FORMAT 'csv', DELIMITER ',', QUOTE '\"', HEADER true, ENCODING 'WINDOWS 1250')" gismentors

cd /tmp
unzip -o ${SCRIPT_PATH}/sldb_obyvatelstvo.zip
cat SLDB_OBYVATELSTVO.CSV  | 
psql -c "COPY ${schema}.sldb FROM STDIN WITH (FORMAT 'csv', DELIMITER ',', QUOTE '\"', HEADER true, ENCODING 'WINDOWS 1250')" gismentors

# ssconvert --export-type=Gnumeric_stf:stf_assistant \
# -O 'separator=; eol=unix sheet=Obyvatelstvo quoting-mode=never format=raw' \
# $${SCRIPT_PATH}/sldb2011_vou.xls ;

tail -n +7 ${SCRIPT_PATH}/sldb2011_vou.txt |
psql -c "COPY ${schema}.polozky FROM STDIN WITH DELIMITER ';' NULL ''" gismentors;

#pozn v ruian je o dvě obce víc
