source venv/bin/activate

docker build -t myapp:debug .
docker run -d --name app_debug -p 8501:8501 myapp:debug
docker exec -it app_debug /bin/bash



1. контенер джобы
2. хеш джобы
docker exec myapp_jobmanager_1 \
  /opt/flink/bin/flink savepoint \
  5d23e0c9f8b72a1c5e9d8f3a2b1c0e9d \
  file:///tmp/savepoints



