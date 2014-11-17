--CREATE SCHEMA if NOT EXISTS gismentors;

SET search_path TO gismentors, public;

drop table silnice;
create table silnice as
select osm_id,st_transform(way, 5514) as geom,1 as typ from czech_line where highway = 'motorway'
union
select osm_id,st_transform(way, 5514) as geom,2 as typ from czech_line where highway = 'trunk'
union
select osm_id,st_transform(way, 5514) as geom,3 as typ from czech_line where highway = 'primary'
union
select osm_id,st_transform(way, 5514) as geom,4 as typ from czech_line where highway = 'secondary'
union
select osm_id,st_transform(way, 5514) as geom,5 as typ from czech_line where highway = 'tertiary';
