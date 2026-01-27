source venv/bin/activate

docker build -t myapp:debug .
docker run -d --name app_debug -p 8501:8501 myapp:debug
docker exec -it app_debug /bin/bash