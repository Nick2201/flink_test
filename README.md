# Apache Flink 101

This repository is for the exericses in the [Apache Flink 101](https://developer.confluent.io/courses/apache-flink/intro/) course hosted on Confluent Developer.

It uses Docker Compose to start up Kafka, Flink, and Flink's SQL CLI.

## Launch

First build the image and start all of the containers:

```bash
docker compose up --build -d
```

Once the containers are running,

```bash
docker compose run sql-client
```

will drop you into the Flink SQL Client, where you can interact with Flink SQL.

## Shutdown

When you're done, this will shutdown all of the containers and delete the volume that was created for checkpointing:

```bash
docker compose down -v
```

## Tables
- Bid
- Bid2
- ItemInfo
- ticker
- Orers
- RatesHistory
### Extras
kafka
- message.format=AVRO

## kafka

- ```docker exec -it kcat sh```
    - ```kcat -b broker:9092 -L to list topics```
    - ```kcat -b broker:9092 -t my-topic -C to consume messages```
    - ```kcat -b broker:9092 -t my-topic -P to produce messages```
