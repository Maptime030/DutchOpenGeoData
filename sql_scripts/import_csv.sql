DROP TABLE IF EXISTS events_utrecht_2011_2016;
CREATE TABLE events_utrecht_2011_2016
(year date, day varchar, date_from_to varchar, weeknr numeric, time_from time,  time_to time, event_naam varchar, location varchar)
;

-- Copy data from your CSV file to the table:
\COPY events_utrecht_2011_2016 FROM 'data/Evenementenoverzicht_2011_2016.csv' DELIMITER ';' HEADER true CSV ;

