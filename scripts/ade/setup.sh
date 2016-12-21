#!/bin/sh
keyvault_name=$1
rg_name=$2
key_name=$3
app_name=$4
password=$5
vm_name=$6
location="westeurope"

result_createkv=$(azure keyvault create --vault-name $keyvault_name --resource-group $rg_name --location $location --json)
keyvault_uri=$(echo $result_createkv | jq -r '.properties.vaultUri')
diskencr_kv_id=$(echo $result_createkv | jq -r '.id')

echo "keyvault_url: $keyvault_uri"
echo "diskencrypt keyv id: $diskencr_kv_id"

kkid=$(azure keyvault key create --vault-name $keyvault_name --key-name $key_name --destination software  --json | jq -r '.key.kid')
echo "kkid $kkid"

azure keyvault set-policy --vault-name $keyvault_name --resource-group $rg_name --enabled-for-disk-encryption true 
appId=$(azure ad app create --name $app_name --home-page http://$app_name --identifier-uris http://$app_name/id --password $password --json | jq -r '.appId')
echo "creating app $app_name with appid $appId"
spnName=$(azure ad sp create --applicationId $appId --json | jq -r '.servicePrincipalNames[0]')
echo "spName is: $spnName"
azure keyvault set-policy --vault-name $keyvault_name --spn $spnName --perms-to-keys [\"all\"] --perms-to-secrets [\"all\"] 


echo "command to be encrypt disk based on these keys:"
echo "azure vm enable-disk-encryption --resource-group $rg_name \
 --name $vm_name \
 --aad-client-id $spnName \
 --aad-client-secret $password \
 --disk-encryption-key-vault-url $keyvault_uri \
 --disk-encryption-key-vault-id $diskencr_kv_id \
 --key-encryption-key-url $kkid \
 --key-encryption-key-vault-id $diskencr_kv_id \
 --volume-type OS "
