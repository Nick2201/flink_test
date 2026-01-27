#Create new sql-client
sql:
	docker compose run sql-client
#Run exist sql-client
INSTANCE_NAME ?= 
sql_exist:
    docker compose run --name ${INSTANCE_NAME} sql-client
job:
	docker compose exec -it jobmanager /bin/bash

app_down:
	docker compose down -v
## pure restart
app_up:
	docker compose up --build -d