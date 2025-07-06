FROM jupyter/scipy-notebook:latest

# Add a build argument that you can change to invalidate the cache
ARG CACHE_BUSTER=1

USER root

# Your RUN command remains the same
RUN pip install playwright matplotlib pandas openpyxl bs4 mechanize lxml gspread gspread-dataframe influxdb-client psycopg2-binary && \
    playwright install --with-deps chromium

USER jovyan