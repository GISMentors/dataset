CREATE SCHEMA if NOT EXISTS osm;

drop table osm.zeleznice;
create table osm.zeleznice as
select osm_id,st_transform(way, 5514) as geom from osm_line
where railway = 'rail';

alter table osm.zeleznice add primary key (osm_id);

create index on osm.zeleznice using gist (geom);

select UpdateGeometrySRID('osm', 'zeleznice', 'geom', 5514);
