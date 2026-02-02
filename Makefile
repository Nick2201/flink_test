#Create new sql-client
sql:
	docker compose run sql-client
job:
	docker compose exec -it jobmanager /bin/bash

app_down:
	docker compose down -v
## pure restart
app_up:
	docker compose up --build -d
app_down:
	docker compose down -v
kafka:
	docker compose exec -it kcat kcat -b broker:9092 -L
# flink:flink /opt/flink/lib