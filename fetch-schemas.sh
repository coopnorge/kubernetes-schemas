#!/usr/bin/env bash

if [ -z "$1" ] ; then
  echo cluster folder as first argument required
  echo example ./fetch-schemas.sh api-staging
  exit 1
fi

SCHEMA_FETCH_SCRIPT=${PWD}/openapi2jsonschema.py
WORKDIR=${1}
export FILENAME_FORMAT='{kind}-{group}-{version}'

ISTIO_VERSION=1.11.6
ISTIO_URL=https://raw.githubusercontent.com/istio/istio/${ISTIO_VERSION}/manifests/charts/base/crds/crd-all.gen.yaml

EXTERNAL_SECRET_MANAGER_VERSION=8.5.5
EXTERNAL_SECRET_MANAGER_URL=https://raw.githubusercontent.com/external-secrets/kubernetes-external-secrets/${EXTERNAL_SECRET_MANAGER_VERSION}/charts/kubernetes-external-secrets/crds/kubernetes-client.io_externalsecrets_crd.yaml

### SETUP
mkdir -p ${WORKDIR}
rm -fr ${WORKDIR}/*

pushd ${WORKDIR}

$SCHEMA_FETCH_SCRIPT $ISTIO_URL
$SCHEMA_FETCH_SCRIPT $EXTERNAL_SECRET_MANAGER_URL

popd