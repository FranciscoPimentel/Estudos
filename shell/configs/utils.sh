#!/bin/bash

function __read_value_s_time()
{
    echo "$2" # O que irá executar ou provisionar
    read tmp_val
    eval "export $1=$tmp_val"
}

# Faz a leitura da variável 
function __read_value()
{
    FINAL_ENV=$1
    REG_MATCH=$2
    TEXT=$3

    __read_value_s_time $FINAL_ENV "$TEXT"

    while ! [[ "${tmp_val}" =~ ${REG_MATCH} ]]; do
        echo "O valor informado nao corresponde a um valor valido."
        
        __read_value_s_time $FINAL_ENV "$TEXT"
    done
}


function __read_value_defFunc()
{
    FINAL_ENV=$1
    CMD_PREFIX=$2
    TEXT=$3

    __read_value_s_time $FINAL_ENV "$TEXT"

    while ! command -v "${CMD_PREFIX}$(echo $tmp_val | tr '[:lower:]' '[:upper:]')"; do
        echo "O valor informado nao corresponde a um valor valido."
        
        __read_value_s_time $FINAL_ENV "$TEXT"
    done
}

# function to collect node access data (qa, prd, teste and ctos)

function __setupEnv_QA()
{
    export ENV_NAME="QA"
    export ENV_SECRET="QA-AnsiblePass"
    export ENV_USER="QA-AnsibleUser"    
    export ENV_VAULT_NAME="SavedCredentials"
    LOCAL_PASSWORD=$(az keyvault secret show --name "$ENV_SECRET" --vault-name "$ENV_VAULT_NAME" -o json | jq -rc '.value')
    LOCAL_USER=$(az keyvault secret show --name "$ENV_USER" --vault-name "$ENV_VAULT_NAME" -o json | jq -rc '.value')
}

function __setupEnv_PRD()
{
    export ENV_NAME="PRD"
    export ENV_SECRET="PRD-AnsiblePass"
    export ENV_USER="PRD-AnsibleUser"    
    export ENV_VAULT_NAME="SavedCredentials"
    LOCAL_PASSWORD=$(az keyvault secret show --name "$ENV_SECRET" --vault-name "$ENV_VAULT_NAME" -o json | jq -rc '.value')
    LOCAL_USER=$(az keyvault secret show --name "$ENV_USER" --vault-name "$ENV_VAULT_NAME" -o json | jq -rc '.value')
}

function __setupEnv_CTOS()
{
    export ENV_NAME="CTOS"
    
    __read_value ENV_SECRET "^.*AnsiblePass$" "Informe o secret para o ambiente: "
}

#  execution in the desired playbook (initial, k8s, opensearch, rabbitmq, haproxy and redis )

function __runPb_INICIAL()
{
    PATH_INIT='../configs_iniciais.yml'
    ansible-playbook -i ../inventario/invent_$environment.yml $PATH_INIT --extra-vars ansible_password='$LOCAL_PASSWORD' ansible_user='$LOCAL_USER' --extra-vars "nodes=$nodes"
}

function __runPb_MONGO()
{
    PATH_MONGODB_INIT='../mongodb'
    ansible-playbook -i ../inventario/invent_$environment.yml $PATH_MONGODB_INIT/teste.yml --extra-vars ansible_password="$LOCAL_PASSWORD" --extra-vars ansible_user="$LOCAL_USER" --extra-vars "nodes=$nodes" -v
}

function __runPb_OPENSEARCH()
{
    PATH_OPENSEARCH_INIT='../opensearch'
    ansible-playbook -i ../inventario/invent_$environment.yml $PATH_OPENSEARCH_INIT/teste.yml --extra-vars ansible_password="$LOCAL_PASSWORD" --extra-vars ansible_user="$LOCAL_USER" --extra-vars "nodes=$nodes" -v
}

function __runPb_RABBITMQ()
{
    PATH_RABBIT_INIT='../rabbitmq'
    ansible-playbook -i ../inventario/invent_$environment.yml $PATH_RABBIT_INIT/teste.yml --extra-vars ansible_password="$LOCAL_PASSWORD" --extra-vars ansible_user=$LOCAL_USER --extra-vars "nodes=$nodes" -v
}

function __runPb_HAPROXY()
{
    
    PATH_HAPROXY_INIT='../haproxy'
    ansible-playbook -i ../inventario/invent_$environment.yml $PATH_HAPROXY_INIT/teste.yml --extra-vars ansible_password="$LOCAL_PASSWORD" --extra-vars ansible_user="$LOCAL_USER" --extra-vars "nodes=$nodes" -v
}    

function __runPb_REDIS()
{
    PATH_REDIS_INIT='../redis' 
    ansible-playbook -i ../inventario/invent_$environment.yml $PATH_REDIS_INIT/teste.yml --extra-vars ansible_password="$LOCAL_PASSWORD" --extra-vars ansible_user="$LOCAL_USER" --extra-vars "nodes=$nodes" -v
}

echo "Imported Functions"