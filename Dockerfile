FROM python:3.8-alpine
#FROM python:3.6.4-alpine3.7

RUN apk add --update curl gcc g++ git libffi-dev openssl-dev python3-dev build-base linux-headers \
    && rm -rf /var/cache/apk/*
RUN ln -s /usr/include/locale.h /usr/include/xlocale.h

ENV PYTHONUNBUFFERED=1 ENVIRONMENT=pre APP_HOME=/microservice/
ENV DATABASE_DIR=database
ENV PYMS_CONFIGMAP_FILE="$APP_HOME"config-docker.yml
RUN mkdir $APP_HOME && adduser -S -D -H python

RUN chown -R python $APP_HOME
WORKDIR $APP_HOME
RUN python -m pip install --user --upgrade pip
RUN pip install pipenv==2021.5.29
#RUN pip install pipenv
COPY Pipfile* /tmp/
RUN cd /tmp && pipenv lock --requirements > requirements.txt
RUN pip install -r /tmp/requirements.txt
RUN pip3 install "Flask==1.1.4"
RUN pip3 install markupsafe==2.0.1
RUN pip3 install swagger-spec-validator
RUN pip3 install openapi-spec-validator
#RUN pip3 install gevent==1.2.2 gunicorn==19.7.1
RUN pip3 install gevent gunicorn
ADD . $APP_HOME

RUN mkdir $DATABASE_DIR
RUN chmod 777 $DATABASE_DIR

EXPOSE 30034
USER python

CMD ["gunicorn", "--workers", "1", "--log-level", "INFO", "--bind", "0.0.0.0:30034", "manage:app"]
