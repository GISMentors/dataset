--CREATE SCHEMA if NOT EXISTS gismentors;

SET search_path TO gismentors, public;

drop table pozarni_stanice;
create table pozarni_stanice as
select osm_id,st_transform(way, 5514) as geom from czech_point where amenity = 'fire_station';
