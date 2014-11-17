CREATE SCHEMA if NOT EXISTS gismentors;

SET search_path TO gismentors, public;

create table zeleznice as
select osm_id,st_transform(way, 5514) as geom from czech_line where railway = 'rail';
