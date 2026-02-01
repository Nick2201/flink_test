# Apache Flink test

## Launch
- ```make app_up```: launc app untill down
- ```make sql```: create new sql session
- ```make job```: dive into job_maneger file-system
- ```make app_down```:  run down: 


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
# SRC:
- [Apache Flink 101](https://developer.confluent.io/courses/apache-flink/intro/) course hosted on Confluent Developer.