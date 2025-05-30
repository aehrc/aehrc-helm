#!/bin/bash

if [ -z "$1" ]; then
  echo "### Error! Please provide the chart name as a parameter"
  exit 1
fi

helm dependency build $1

az login --scope https://management.core.windows.net//.default

ACR_NAME="ontoserver"
USER_NAME="helmtoken"
PASSWORD=$2

# To create a password use thise code
# (az acr token create -n $USER_NAME \
#                  -r $ACR_NAME \
#                  --scope-map _repositories_admin \
#                  --only-show-errors \
#                  --query "credentials.passwords[0].value" -o tsv)

helm registry login $ACR_NAME.azurecr.io \
  --username $USER_NAME \
  --password $PASSWORD

chart_name=$(helm package $1 | sed 's|.*saved it to: .*/||')

echo "### Pushing $chart_name to oci://$ACR_NAME.azurecr.io/helm"

helm push $chart_name oci://$ACR_NAME.azurecr.io/helm