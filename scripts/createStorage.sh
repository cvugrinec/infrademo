#!/bin/sh
#=========================================
#
#       file:   createStorage.sh
#       author: chvugrin@microsoft.com
#       description: creates a storage account based on template
#
#=========================================
rg=$1
#/opt/scripts/infra-app1/loginToAzure.sh 
azure group deployment create --template-file /opt/templates/az-storage.json $rg
