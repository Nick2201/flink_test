
from pyflink import datastream
from pyflink.datastream import StreamExecutionEnvironment
from pyflink.datastream.connectors import FlinkKafkaConsumer
from pyflink.common.typeinfo import Types
from pyflink.datastream.formats.json import JsonRowDeserializationSchema
import streamlit as st
import pandas as pd
# import plotly.graph_objects as go
import numpy as np
from datetime import datetime, timedelta

from pyflink.table import StreamTableEnvironment
from pyflink.datastream import StreamExecutionEnvironment

# 1. Создаем среду выполнения
env = StreamExecutionEnvironment.get_execution_environment()
env.set_parallelism(1)  # Для локального тестирования

# 2. Создаем TableEnvironment
t_env = StreamTableEnvironment.create(env)
def main():
    st.title('Stock Market Candlestick Generator')
    # Sidebar for configuration
    st.sidebar.header('Configuration')
    st.subheader(f'Generated Candlestick Data : {t_env}')

if __name__ == '__main__':
    main()
# env = StreamExecutionEnvironment.get_execution_environment()
# print(env)
