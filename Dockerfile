FROM python:3.14.6-alpine3.24
RUN apk --no-cache add bats curl
COPY requirements.txt /code/
RUN pip install -r /code/requirements.txt
COPY  openapi2jsonschema.py /code/
COPY fetch-schemas-api-platform.sh /code/
WORKDIR /code
