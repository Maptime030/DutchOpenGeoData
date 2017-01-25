# DIY Dutch Open Geo Data

From Frank Verchoor we got an Excel file with all the events in Utrecht from 2011 to 2016. This events have a data, time and location. 

**Let's map this!**

So how do we do this? Because the dataset did not contain any coordinates we first need to geo refer these locations. For this we can use the BAG with all the adresses. Below you can see the steps I took to get coordinates to our dataset!

By cloning this repository you can reprocuce these steps for yourself in Postgis. 

You do not want to work with Postgis? The [pre-processed dataset](/data/.csv) is available for you as well! Just download this and import this to Qgis, R or anything you like!

**Good luck!**


## Geolocating location names:

#### 1. Excel to csv

I already put all data into one sheet with the year as extra column. This is exported to a csv file. 

#### 2. csv to Postgis

	psql -h localhost -d $DB -U $USER -p $PORT-W -f sql_scirpts/import_csv.sql

#### 3. BAG to Postgis 

Download the BAG and put in Postgis with pg_restore

	wget data.nlextract.nl/bag/postgis/bag-laatst.backup 

	pg_restore --create --exit-on-error --verbose -h localhost -d $DB -p $PORT -U $USER -W $PSSWRD -j `nproc` --no-owner --no-privileges bag-2016_10_13.backup

#### 4. BAG for Utrecht on street level

We only need the adresses in Utrecht. Plus we need only one point per street. Because we do not have full adresses. There are 2 choices for this, either we take the centre of the adresses per street or the first GID of the street as our location point.
Both RDnew coordinates and Lat Long will be computed. 

	psql -h localhost -d $DB -U $USER -p $PORT-W -f sql_scirpts/bag_adres.sql

Export our table to a csv file for you to use! (or use the postgis database)

	ogr2ogr postgis to csv.  