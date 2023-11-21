#!/bin/bash

    export ENV_NAME="QA"
    export ENV_SECRET="QA-AnsiblePass"
    export ENV_USER="QA-AnsibleUser"    
    export ENV_VAULT_NAME="SavedCredentials"
# LOCAL_PASSWORD=$(az keyvault secret show --name $ENV_SECRET --vault-name $ENV_VAULT_NAME -o json | jq -rc '.value')
# LOCAL_USER=$(az keyvault secret show --name $ENV_USER --vault-name $ENV_VAULT_NAME -o json | jq -rc '.value'0)
# LOCAL_PASSWORD=$(az keyvault secret show --name QA-AnsiblePass --vault-name SavedCredentials -o json | jq -rc '.value')
# LOCAL_USER=$(az keyvault secret show --name QA-AnsibleUser --vault-name SavedCredentials -o json | jq -rc '.value')

PATH_HAPROXY_INIT='haproxy'

echo "informe enviroment" $ENV_SECRET, $ENV_USER e $ENV_VAULT_NAME

LOCAL_PASSWORD=$(az keyvault secret show --name $ENV_SECRET --vault-name $ENV_VAULT_NAME -o json | jq -rc '.value')
LOCAL_USER=$(az keyvault secret show --name $ENV_USER --vault-name $ENV_VAULT_NAME -o json | jq -rc '.value')

echo "informe ambiente" 
read environment
echo "informe ndoes"
read nodes

ansible-playbook -i inventario/invent_$environment.yml $PATH_HAPROXY_INIT/teste.yml --extra-vars ansible_password="'$LOCAL_PASSWORD'" --extra-vars ansible_user=$LOCAL_USER --extra-vars "nodes=$nodes" -v
#ansible-playbook -i inventario/invent_qa.yml haproxy/teste.yml --extra-vars "nodes=haproxy" --extra-vars ansible_password='1q2w3e!Q@W#E' --extra-vars  ansible_user=infra 