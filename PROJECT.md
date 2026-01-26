# Financial Data Streaming Project with Apache Flink

## Project Overview
This project implements a real-time financial data streaming solution using Apache Flink for processing and Streamlit for visualization. The system receives financial instrument price data from a streaming API, processes it in different time frames (seconds, minutes, hours), and provides real-time visualization.

## Architecture Components

### 1. Streaming API Integration
- **Data Source**: REST API providing real-time financial instrument prices
- **Data Fields**: 
  - `price_open`: Opening price of the financial instrument
  - `price_close`: Closing price of the financial instrument
  - `time`: Timestamp of the price data
  - `instrument`: Identifier for the financial instrument (e.g., stock symbol)
- **API Access**: Secure API key authentication mechanism needed

### 2. Apache Flink Processing Layer
- **Stream Processing**: Real-time processing of financial data streams
- **Time Frame Conversion**: Aggregate data into different time windows:
  - Second-level frames for high-frequency trading insights
  - Minute-level frames for short-term analysis
  - Hour-level frames for medium-term trends
- **Data Transformation**: Process raw price data into aggregated frames
- **Output**: Forward processed frame data to downstream services

### 3. Streamlit Visualization Layer
- **Real-time Plots**: Interactive charts showing financial data trends
- **Multi-timeframe Views**: Display data across different aggregation periods
- **Responsive UI**: Near real-time updates as new data arrives
- **Instrument Selection**: Allow users to select and view different financial instruments

## Technical Requirements

### API Key Management
- Secure storage and transmission of API keys
- Possible integration with external secret management systems
- Consider environment variables or secure vault solutions

### Data Flow
```
Streaming API -> Apache Flink -> Time Frame Aggregation -> Downstream Service -> Streamlit Visualization
```

### Scalability Considerations
- Horizontal scaling for handling high-volume financial data
- Fault tolerance for continuous operation
- Efficient state management for windowed aggregations

## Docker Compose Setup
The project will require containers for:
- Apache Flink cluster (JobManager and TaskManager)
- Streaming API client/service
- Streamlit application
- Possibly Kafka/Zookeeper for message queuing if needed
- Database for storing processed frames (optional)

## Development Goals
1. Implement real-time financial data ingestion
2. Create time-windowed aggregations using Apache Flink
3. Build responsive Streamlit dashboard for visualization
4. Ensure low-latency processing for near real-time insights