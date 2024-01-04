#!/usr/bin/env bash

if [ -z "$1" ] ; then
  echo cluster folder as first argument required
  echo example ./fetch-schemas.sh api-platform
  exit 1
fi

SCHEMA_FETCH_SCRIPT=${PWD}/openapi2jsonschema.py
WORKDIR=${1}
export FILENAME_FORMAT='{kind}-{group}-{version}'

ISTIO_VERSION=1.11.6
ISTIO_URL=https://raw.githubusercontent.com/istio/istio/${ISTIO_VERSION}/manifests/charts/base/crds/crd-all.gen.yaml

EXTERNAL_SECRET_MANAGER_VERSION=v0.9.11
EXTERNAL_SECRET_MANAGER_URL=https://raw.githubusercontent.com/external-secrets/external-secrets/${EXTERNAL_SECRET_MANAGER_VERSION}/config/crds/bases/external-secrets.io_externalsecrets.yaml

### SETUP
mkdir -p ${WORKDIR}
rm -fr ${WORKDIR}/*

pushd ${WORKDIR}

$SCHEMA_FETCH_SCRIPT $ISTIO_URL
$SCHEMA_FETCH_SCRIPT $EXTERNAL_SECRET_MANAGER_URL

popd
