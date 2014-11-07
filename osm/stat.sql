alter table staty_generalizovanehranice rename to stat;
ALTER SEQUENCE staty_generalizovanehranice_ogc_fid_seq rename to stat_ogc_fid_seq;

alter table stat add column geom_osm geometry(multipolygon, 900913);

update stat set geom_osm = st_transform(wkb_geometry, 900913); 

create index stat_gidx ON stat USING GIST (geom_osm);
