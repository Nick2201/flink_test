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
- bounded_pageviews
- streaming_pageviews
- pageviews

### Extras
kafka
- message.format=AVRO

## Docker Images
- kafka
    - Basic: apache/kafka:4.0.0 
    - UI: obsidiandynamics/kafdrop

## RUN

- ```docker exec -it kcat sh```
    - ```kcat -b broker:9092 -L to list topics```
    - ```kcat -b broker:9092 -t my-topic -C to consume messages```
    - ```kcat -b broker:9092 -t my-topic -P to produce messages```




### My Kafka configuiation

|Name                        |Description

|----------------------------|-------------------------------

|`KAFKA_BROKERCONNECT`       |Bootstrap list of Kafka host/port pairs. Defaults to `localhost:9092`.

|`KAFKA_PROPERTIES`          |Additional properties to configure the broker connection (base-64 encoded).

|`KAFKA_TRUSTSTORE`          |Certificate for broker authentication (base-64 encoded). Required for TLS/SSL.

|`KAFKA_KEYSTORE`            |Private key for mutual TLS authentication (base-64 encoded).