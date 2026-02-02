FROM flink:1.20.2-scala_2.12-java11

RUN wget -P /opt/flink/lib/ https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-kafka/3.4.0-1.20/flink-sql-connector-kafka-3.4.0-1.20.jar; \
    wget -P /opt/flink/lib/ https://github.com/knaufk/flink-faker/releases/download/v0.5.3/flink-faker-0.5.3.jar;

RUN chown -R flink:flink /opt/flink/lib

# Install Python
RUN apt-get update && \
    apt-get install -y openjdk-21-jdk && \
    apt-get install -y ant && \
    apt-get clean;

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-arm64

WORKDIR /opt/flink
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY download_libs.sh .
RUN chmod +x ./download_libs.sh && ./download_libs.sh

COPY ./usr_jobs/ ./usr_jobs