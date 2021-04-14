# HYFAA-MGB platform

This project is aggregating the several components used for the HYFAA/MGB platform:
- the HYFAA scheduler coded by Magellium
- a PostGIS database where the data destined for visualization in the platform is published
- the backend (Python, Flask)
- the frontend (VueJS)

## Use this repo
### Clone it
Clone this repository if you haven't already:

`git clone --recurse-submodule https://github.com/OMP-IRD/hyfaa-mgb-platform.git`

### Update
If you have already cloned it, you should update it:

`git pull --recurse-submodules`

## Build the docker images
`docker-compose -f docker-compose.yml -f docker-compose-production.yml build`

or if you're going to just use it for development

`docker-compose build`

## Run the platform
Several docker-compose files are provided, that you can mix depending on the scenario

### Run the platform for a test run (no scheduler data processing)
Run `docker-compose up`.

The platform will start, but no data will be loaded or processed.

### Run the platform in production mode (launch the hyfaa scheduler on startup)
**You first need to apply the instructions from the [scheduler's README](hyfaa-scheduler/work_configurations/operational_niger_gsmap/README.md)**

Then start the composition:
```
docker-compose -f docker-compose.yml -f docker-compose-production.yml up
```
This will start the platform, _and_ the scheduler for a first run.

If it is truly the first run, it will take a looong time (approx 1h), because the scheduler will initialize the model (and publish it, first time, in the DB).
Then it stops, the data will be published in the DB and the web platform will be fully operational _(this step is not yet implemented)_

There is no built-in CRON task to re-run the HYFAA scheduler. You'll have to run it manually (`docker-compose -f docker-compose.yml -f docker-compose-production.yml start scheduler`) or program yourself a CRON task on your machine, running the same command.

#### Publishing the data into the DB
After the scheduler has finished running, you'll want to publish the data into the database. This is done using a script from (for now) the hyfaa-backend container.
You can do it with the following command:
```
docker-compose run backend python3 /hyfaa-backend/app/scripts/hyfaa_netcdf2DB.py /hyfaa-scheduler/data/
```

_Note_: you can just load the latest values by adding ` --only_last_n_days 20` at the end of this command.

#### CRON task
To run the scheduler and publish the data, the recommended way is to create a cron task that chains the scheduler run and this publication command.

### Run the platform in dev mode
In [platform] dev mode, most likely, you won't want to run the scheduler, because it takes a lot of time and resources.
You'd rather want to load into the DB some sample data. You can do this with
```
docker-compose -f docker-compose.yml -f docker-compose-dev.yml up
```

The pg_tileserv server is accessible on http://localhost/tiles

The interesting layers are:
- **hyfaa.data_with_assim_aggregate_geo**: the MGB/HYFAA flow data for the last 15 days, in a json field (list of { date, flow_median, flow_anomaly} objects).
- **geospatial.stations_geo**: the stations that can be queried for graph view
