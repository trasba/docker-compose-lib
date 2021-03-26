FROM python:3.7-alpine

ENV PATH="/scripts:${PATH}"

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache --virtual .tmp gcc libc-dev linux-headers
RUN pip install -r /requirements.txt
RUN apk del .tmp

# set default environment variables
ENV PYTHONUNBUFFERED 1

RUN cd / && django-admin startproject app
# RUN mkdir /app
# COPY ./app /app
WORKDIR /app
COPY ./scripts /scripts

RUN chmod +x /scripts/*

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
RUN adduser -D abc
RUN chown -R abc:abc /vol
RUN chmod -R 755 /vol/web
USER abc

CMD ["entrypoint.sh"]