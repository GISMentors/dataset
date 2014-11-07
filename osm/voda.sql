CREATE SCHEMA if NOT EXISTS gismentors;

SET search_path TO gismentors, public;

-- vodni_toky
drop table if exists vodni_toky;
create table vodni_toky as select o.osm_id, o.name as nazev, o.waterway as typ,
       st_transform(st_intersection(o.way, s.geom_osm), 5514) as geom
       from czech_line as o join stat as s on st_intersects(o.way, s.geom_osm)
            where o.waterway in ('river', 'stream', 'canal');

-- vodni_plochy
drop table if exists vodni_plochy;
create table vodni_plochy as select o.osm_id,o.name as nazev,o.water as typ,
       st_transform(st_intersection(o.way,s.geom_osm), 5514) as geom 
       from czech_polygon as o cross join stat as s
       where o.landuse = 'reservoir';
