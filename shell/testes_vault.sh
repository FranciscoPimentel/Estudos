#!/bin/bash

#source ./utils.sh
source ./configs/utils.sh
source ./configs/k8s_utils.sh
#source ./configs/colors.sh

__read_value_defFunc environment "__setupEnv_" ${Green}"Informe o inventário: ${Clear} "

__read_value_defFunc playbook "__runPb_" "Informe o que o aplicação ou playbook ansible que deseja executar: "

__read_value nodes "^.*$" "Informe os nodes: "

echo "Setup environment $environment..." \
    && "__setupEnv_$(echo $environment | tr '[:lower:]' '[:upper:]')" 
echo "Running playbook $playbook..." \
    && "__runPb_$(echo $playbook | tr '[:lower:]' '[:upper:]')" 

