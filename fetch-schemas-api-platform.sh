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

OLD_EXTERNAL_SECRET_VERSION=8.5.5
OLD_EXTERNAL_SECRET_MANAGER_URL=https://raw.githubusercontent.com/external-secrets/kubernetes-external-secrets/${OLD_EXTERNAL_SECRET_VERSION}/charts/kubernetes-external-secrets/crds/kubernetes-client.io_externalsecrets_crd.yaml

echo $OLD_EXTERNAL_SECRET_MANAGER_URL

KEDA_VERSION=v2.16.1
KEDA_SCALED_JOB_URL=https://raw.githubusercontent.com/kedacore/keda/${KEDA_VERSION}/config/crd/bases/keda.sh_scaledjobs.yaml
KEDA_TRIGGER_AUTHENTICATION_URL=https://raw.githubusercontent.com/kedacore/keda/${KEDA_VERSION}/config/crd/bases/keda.sh_triggerauthentications.yaml

GKE_SCHEMAS_OPENAPIV2=${PWD}/gke-schemas

# Elastic Cloud on Kubernetes (ECK) CRDs
# https://github.com/elastic/cloud-on-k8s
ECK_VERSION=v3.0.0
ECK_ALL_CDRS_URL=https://raw.githubusercontent.com/elastic/cloud-on-k8s/refs/tags/${ECK_VERSION}/config/crds/v1/all-crds.yaml

### SETUP
mkdir -p ${WORKDIR}
rm -fr ${WORKDIR}/*

pushd ${WORKDIR}

$SCHEMA_FETCH_SCRIPT $ISTIO_URL
$SCHEMA_FETCH_SCRIPT $EXTERNAL_SECRET_MANAGER_URL
$SCHEMA_FETCH_SCRIPT $OLD_EXTERNAL_SECRET_MANAGER_URL
$SCHEMA_FETCH_SCRIPT $KEDA_SCALED_JOB_URL
$SCHEMA_FETCH_SCRIPT $KEDA_TRIGGER_AUTHENTICATION_URL
$SCHEMA_FETCH_SCRIPT $ECK_ALL_CDRS_URL

cp $GKE_SCHEMAS_OPENAPIV2/*.json ./

popd
