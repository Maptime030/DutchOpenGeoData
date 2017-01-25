DROP TABLE IF EXISTS events_utrecht_2011_2016;
CREATE TABLE events_utrecht_2011_2016
(year numeric, day varchar, date_from_to varchar, weeknr varchar, time_from varchar,  time_to varchar, event_naam varchar, location varchar)
;

-- Copy data from your CSV file to the table:
\COPY events_utrecht_2011_2016 FROM 'data/Evenementenoverzicht_2011_2016.csv' NULL '' DELIMITER ';' HEADER CSV ;

