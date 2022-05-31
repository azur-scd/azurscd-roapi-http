# azurscd-roapi-http

ROAPI is a magic python tool that converts static files in http API and SQL query frontend.

- the data schema is automatically infered from files
- the tool provides also a connector for Sqlite and MySQL databases
- the query frontend provides 3 sorts of endpoints : SQL (for POST SQL queries), GraphQL and REST API (only GET)
- structured data can be serialized in Json, Arrow and Parquert formats

## Official documentation

- [https://roapi.github.io/docs/index.html](https://roapi.github.io/docs/index.html)
- [https://github.com/roapi/roapi](https://github.com/roapi/roapi)

## Implementation

This Docker image is a local implementation of ROAPI using a YAML config file (in /config folder) to connect to Github hosted datafiles.

The goal of using ROAPI is to quickly and easily implement a middleware of GET APIs to all the data of the SI_SCD whenever their source.

## Installation

### Create image

```
docker build  -t azurscd/roapi-http:latest .
```

The exposed port is 8084 and the /datasets and /congig folders can be binded as volumes in the container.


### Run container

```
docker run --name roapi-http -t -v YOUR_PATH/config:/config -v YOUR_PATH/datasets:/datasets -p 8084:8084 azurscd/roapi-http:latest
```