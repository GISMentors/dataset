--CREATE SCHEMA if NOT EXISTS gismentors;

SET search_path TO gismentors, public;

drop table silnice;
create table silnice as
-- select osm_id, st_transform(st_intersection(foo.way, s.geom_osm), 5514) as geom, typ from (
select osm_id,way,1 as typ from czech_line where highway = 'motorway'
union
select osm_id,way,2 as typ from czech_line where highway = 'trunk'
union
select osm_id,way,3 as typ from czech_line where highway = 'primary'
union
select osm_id,way,4 as typ from czech_line where highway = 'secondary'
union
select osm_id,way,5 as typ from czech_line where highway = 'tertiary';
-- ) as foo cross join stat as s;
