CREATE SCHEMA if NOT EXISTS osm;

drop table osm.silnice;
create table osm.silnice as
select osm_id,st_transform(way,5514) as geom,1 as typ from osm_line
where highway = 'motorway'
union
select osm_id,st_transform(way,5514) as geom,2 as typ from osm_line
where highway = 'trunk'
union
select osm_id,st_transform(way,5514) as geom,3 as typ from osm_line
where highway = 'primary'
union
select osm_id,st_transform(way,5514) as geom,4 as typ from osm_line
where highway = 'secondary'
union
select osm_id,st_transform(way,5514) as geom,5 as typ from osm_line
where highway = 'tertiary';

--alter table osm.silnice add primary key (osm_id);

create index on osm.silnice using gist (geom);

alter table osm.silnice alter column geom type geometry(linestring, 5514);
