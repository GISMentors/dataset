create index czech_line_gidx ON czech_line USING GIST (way);

alter table stat add column geom_osm geometry(multipolygon, 900913);

update stat set geom_osm = st_transform(geom, 900913); 

create index stat_gidx ON stat USING GIST (geom_osm);
