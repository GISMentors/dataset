#!/usr/bin/python3

from owslib.wfs import WebFeatureService

url='http://gis.nature.cz/arcgis/services/UzemniOchrana/ChranUzemi/MapServer/WFSServer'
chranena_uzemi_wfs = WebFeatureService(url)
for rec in chranena_uzemi_wfs.contents:
   print (bytes(rec, 'utf-8'))

identifier = 'ChranUzemi:Velkoplo\xc5\xa1n\xc3\xa9_zvl\xc3\xa1\xc5\xa1t\xc4\x9b_chr\xc3\xa1n\xc4\x9bn\xc3\xa9_\xc3\xbazem\xc3\xad'
features = chranena_uzemi_wfs.getfeature([identifier])
print (features)
