CREATE SCHEMA if NOT EXISTS gismentors;

SET search_path TO gismentors, public;

-- vodni_toky
drop table if exists vodni_toky;
create table vodni_toky as select o.osm_id, o.waterway as typ,
       st_intersection(o.way, s.geom_osm) as geom
       from czech_line as o join stat as s on st_intersects(o.way, s.geom_osm)
            where o.waterway in ('river', 'stream', 'canal');

-- vodni_plochy
drop table if exists vodni_plochy;
create table vodni_plochy as select o.osm_id from czech_polygon where="natural='water'";
