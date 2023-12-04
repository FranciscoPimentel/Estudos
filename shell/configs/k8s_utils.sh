#!/bin/bash
#
# Valores Para provisionamento de serviço

function __read_value_s_time()
{
    echo "$2" # O que irá executar ou provisionar
    read tmp_val
    eval "export $1=$tmp_val"
}

# 
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
        echo "Os DADOS informados nao corresponde a um valor valido:"
        
        __read_value_s_time $FINAL_ENV "$TEXT"
    done
}

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

function __runPb_K8S()
{
    PATH_K8S_INIT='../kubernetes/01-k8s_install_config'
      echo -e n "Menu de Escolha \n\n"
      echo "1 - Instalação Kubernetes e ferramentas e configs iniciais ${Green}'01-k8s_install.yml'${Clear}!"
      echo "2 - Init o primeiro Master '02-k8s_init_master.yml'"
      echo "3 - Adicioando Worker'(s) ao cluster '03-k8s_init_worker.yml'"
      echo "4 - Adicioando ControlPlane'(s) ao cluster '04-k8s_init_control_planes.yml'"
      echo "5 - Aplicando otimização ao nós que foram adicionados '05-k8s_otimizacao.yml'"
      echo "6 - Adicionando Worker ao cluster '06-k8s-configs_iniciais'"
      echo -e "6 - Fim\n"
      echo -n "Escolha uma opção -> "
      read op
      case $op in
        1)ansible-playbook -i ../inventario/invent_$environment.yml $PATH_K8S_INIT/teste.yml --extra-vars ansible_password="$LOCAL_PASSWORD" --extra-vars ansible_user="$LOCAL_USER" --extra-vars "nodes=$nodes" -v;;
        2)ansible-playbook -i ../inventario/invent_$environment.yml $PATH_K8S_INIT/02-teste.yml --extra-vars ansible_password="$LOCAL_PASSWORD" --extra-vars ansible_user="$LOCAL_USER" --extra-vars "nodes=$nodes" -v;;
        3)ansible-playbook -i ../inventario/invent_$environment.yml $PATH_K8S_INIT/02-teste.yml --extra-vars ansible_password="$LOCAL_PASSWORD" --extra-vars ansible_user="$LOCAL_USER" --extra-vars "nodes=$nodes" -v;;
        4)echo "sei la ";;
        5)ansible --help;;
        *)pip3;;
      esac
}
echo "Imported Functions"
