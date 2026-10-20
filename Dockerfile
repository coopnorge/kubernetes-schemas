FROM python:3.14.8-alpine3.24@sha256:f6a589d43c42b9e7f7dc67a12d37132491f362859a5d750607710cc56da3bc72
RUN apk --no-cache add bats curl
COPY requirements.txt /code/
RUN pip install -r /code/requirements.txt
COPY  openapi2jsonschema.py /code/
COPY fetch-schemas-api-platform.sh /code/
WORKDIR /code
