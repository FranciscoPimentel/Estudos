#!/bin/bash
#
# Primeiro script para criação de um ambiente (K8s, OpenSearch, Haproxy, RabbitMq, Redis, Storage NFS, Upgrade) 
#https://www.baeldung.com/linux/check-variable-exists-in-list
#https://stackoverflow.com/questions/2312762/compare-difference-of-two-arrays-in-bash

#source ./script_bash/call_function.sh
#source ./inventario/create_invet.sh

#source ./k8s_function.sh

echo "Existe cluster: "YES" OU "NO" " 
read exist_cluster

if [ "$exist_cluster" == "yes" ]
then
  echo "existe cluste" 
  # source ./script_bash/call_function.sh
  # __read_value_defFunc environment "__setupEnv_" "Informe o inventário: "

  # __read_value_defFunc playbook "__runPb_" "Informe o que o aplicação ou playbook ansible que deseja executar: "
  # __read_value nodes "^.*$" "Informe os nodes: "
  # echo "Setup environment $environment..." \
  #     && "__setupEnv_$(echo $environment | tr '[:lower:]' '[:upper:]')" 
  # echo "Running playbook $playbook..." \
  #     && "__runPb_$(echo $playbook | tr '[:lower:]' '[:upper:]')" 
  # echo "Servers actions  $nodes..." \
  #     && "__runPb_$(echo $nodes )" 
elif [ "$exist_cluster" == "no" ]; then
  echo "Deseja criar um arquivo de inventário, lembrando que será necessário os seguintes dados:
  - Ambiente, exemplo: qa,prd,teste...etc;
  - IPs;
  - Variáveis, exemplo:versão, flags adicioandos ao ambiente, etc...,
  "
  echo "Vamos seguir com a instalação "YES" ou "NO" "  
  read choice_option
    if [ "$choice_option" == "yes" ]; then
      ls -la 
    fi 
else
echo "escolha direito boca de burro" 
fi
# echo "1 -" "$1" 
# echo "2 -" "$2" 
# echo "3 -" "$3"
echo "tmp -" "$tmp_val" 
echo "Final - " "$FINAL_ENV" 
echo "reg match" "$REG_MATCH"
echo "text"  "$TEXT"
echo "nodes:" "$nodes" 

# myfun #calling function

# echo "The name of first fruit is $var1"
# #trying to access local variable
# echo "The name of second fruit is $var2"
# echo "The name of third fruit is $var3"


# PATH_COMMON="./common"
# PATH_INVENT="./inventario"
# PATH_CONFIGS="./sysctl_configs"
# #
# echo "Informe o environment:  "
# read environment

# echo "Informe o serviço que deseja realizar as ações: "
# read environment  

# echo "Informe os servers que deseja realizar ação:  "
# read servers

# echo "Você escolheu o environment $environment, serviço $service, nos servers $servers." 

# ###
# __read_value_defFunc environment "__setupEnv_" "Informe o inventário: "

# __read_value_defFunc playbook "__runPb_" "Informe o que o aplicação ou playbook ansible que deseja executar: "

# __read_value nodes "^.*$" "Informe os nodes: "

# echo "Setup environment $environment..." \
#     && "__setupEnv_$(echo $environment | tr '[:lower:]' '[:upper:]')" 
# echo "Running playbook $playbook..." \
#     && "__runPb_$(echo $playbook | tr '[:lower:]' '[:upper:]')" 

# # Validação de ambiente 
