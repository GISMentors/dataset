CREATE SCHEMA if NOT EXISTS osm;

drop table osm.pozarni_stanice;
create table osm.pozarni_stanice as
select osm_id,st_transform(way, 5514) as geom from osm_point
where amenity = 'fire_station';

alter table osm.pozarni_stanice add primary key (osm_id);

create index on osm.pozarni_stanice using gist (geom);

select UpdateGeometrySRID('osm', 'pozarni_stanice', 'geom', 5514);
