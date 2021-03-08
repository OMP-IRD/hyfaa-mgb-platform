# HYFAA-MGB platform

This project is aggregating th several components used for the HYFAA/MGB platform:
- the HYFAA scheduler coded by Magellium
- a PostGIS database where the data destined for vizualization in the platform is published
- the backend (Python, Flask)
- the frontend (VueJS)

## Build the docker images
`docker-compose build`

## Run the platform
A docker-compose file is provided so you can easily run it.

The first run (`docker-compose up [-d]`) will take a looong time (approx 1h), because the scheduler will initialize the model (and publish it, first time, in the DB).
Then it stops, and the web platform will be operational.

There is no built-in CRON task to re-run the HYFAA scheduler. You'll have to run it manually (`docker-compose start hyfaa-scheduler`) or program yourself a CRON task on your machine, running the same command.