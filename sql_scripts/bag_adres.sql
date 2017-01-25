-- Create table with one point per openbareruimtenaam in Utrecht. Based on first GID number of the street. 
DROP TABLE IF EXISTS bag_utrecht_first_gid CASCADE;
CREATE TABLE bag_utrecht_first_gid AS
SELECT 
	gid,
	openbareruimtenaam,
	geopunt
FROM bagactueel.adres
WHERE gid IN (SELECT MIN(gid) FROM bagactueel.adres WHERE gemeentenaam = 'Utrecht' GROUP BY openbareruimtenaam)
;

-- Create table with one point per openbareruimtenaam in Utrecht. Based on the centre of the street points. 
DROP TABLE IF EXISTS bag_utrecht_centre_street CASCADE;
CREATE TABLE bag_utrecht_centre_street AS
SELECT 
	openbareruimtenaam,
	ST_Centroid(ST_Collect(ST_Force_2D(geopunt)))::geometry(POINT, 28992) as geom
FROM bagactueel.adres
WHERE gemeentenaam = 'Utrecht'
GROUP BY openbareruimtenaam; 

-- Join the events table to the BAG location points on openbareruimtenaam. 
SELECT 
	a.*,
	b.openbareruimtenaam,
	ST_X(b.geopunt)::integer AS rdx,
	ST_Y(b.geopunt)::integer AS rdy,
	ST_X(ST_Transform(ST_SetSRID(ag.geopunt,28992),4326))::numeric(9,6) AS lon,
	ST_Y(ST_Transform(ST_SetSRID(ag.geopunt,28992),4326))::numeric(9,6) AS lat
FROM 
	public.events_utrecht_2011_2016 AS e
LEFT OUTER JOIN 
	public.bag_utrecht_first_gid AS b
ON 
	e.location = b.openbareruimtenaam
GROUP BY b.openbareruimtenaam, b.geopunt 
;
