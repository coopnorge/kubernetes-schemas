#!/usr/bin/env bash

if -z $1 ; then
  echo cluster folder as first argument required
  echo example ./fetch-schemas.sh api-staging
  exit 1
fi

SCHEMA_DIR=/master-standalone-strict

WORKDIR=${1}/${SCHEMA_DIR}

ISTIO_VERSION=1.11.6
ISTIO_URL=https://raw.githubusercontent.com/istio/istio/${ISTIO_VERSION}/manifests/charts/base/crds/crd-all.gen.yaml

EXTERNAL_SECRET_MANAGER_VERSION=8.5.5
EXTERNAL_SECRET_MANAGER_URL=https://raw.githubusercontent.com/external-secrets/kubernetes-external-secrets/${EXTERNAL_SECRET_MANAGER_VERSION}/charts/kubernetes-external-secrets/crds/kubernetes-client.io_externalsecrets_crd.yaml

### SETUP
mkdir -p ${WORKDIR}
rm -fr ${WORKDIR}/*

pushd ${WORKDIR}

### ISTIO
curl $ISTIO_URL | yq eval  - -o json -s '.spec.names.singular + "-" + .spec.group + "-v1beta1"'
ls *istio.io-v1beta1.json | sed 'p;s/\.istio\.io//' | xargs -n2 mv

### EXTERNAL_SECRET_MANAGER (OLD)
curl $EXTERNAL_SECRET_MANAGER_URL | yq eval - -o json > externalsecret-kubernetes-client-v1.json

popd ${SCHEMA_DIR}