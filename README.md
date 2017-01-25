## Process:

### Excel to csv

I already put all data into one sheet with the year as extra column. This is exported to a csv file. 

### csv to Postgis

	psql -h localhost -d $DB -U $USER -p $PORT-W -f sql_scirpts/import_csv.sql

### BAG to Postgis 

Download the BAG and put in Postgis with pg_restore

	wget data.nlextract.nl/bag/postgis/bag-laatst.backup 

	pg_restore --create --exit-on-error --verbose -h localhost -d $DB -p $PORT -U $USER -W $PSSWRD -j `nproc` --no-owner --no-privileges bag-2016_10_13.backup

## BAG for Utrecht on street level

We only need the adresses in Utrecht. Plus we need only one point per street. Because we do not have full adresses. There are 2 choices for this, either we take the centre of the adresses per street or the first GID of the street as our location point.
Both RDnew coordinates and Lat Long will be computed. 

	psql -h localhost -d $DB -U $USER -p $PORT-W -f sql_scirpts/bag_adres.sql

Export our table to a csv file for you to use! (or use the postgis database)

	ogr2ogr postgis to csv.  