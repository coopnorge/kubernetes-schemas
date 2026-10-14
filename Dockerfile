FROM python:3.14.7-alpine3.24@sha256:9e9fde4d32eedce0b661d9ab91e826b62dddf28e928c230ec55f1866cac66b01
RUN apk --no-cache add bats curl
COPY requirements.txt /code/
RUN pip install -r /code/requirements.txt
COPY  openapi2jsonschema.py /code/
COPY fetch-schemas-api-platform.sh /code/
WORKDIR /code
