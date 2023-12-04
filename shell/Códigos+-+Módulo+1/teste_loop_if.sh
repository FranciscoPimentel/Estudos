#! /bin/bash

array=("one" "two" "potatoes" "bananas" "three" "apples")
echo="informe o value"
read frta 
# value=$1
echo "$frta"

if [[ $(echo ${array[@]} | grep "$frta") ]]
then
  echo "value found"
else
  echo "value not found"
fi


====

# #!/bin/bash

# # function __read_value()
# # {
# #     FINAL_ENV=$1
# #     REG_MATCH=$2
# #     TEXT=$3
# #     SERVERS_INVENT=$(ansible all -i inventario/invent_teste.yml --list-hosts)
# #     GROUPS_SERVERS_INVENT=$(ansible -i inventario/invent_teste.yml workers -m debug -a "var=groups")

# #     __read_value_s_time $FINAL_ENV  "$TEXT"

# #     while ! [[ "${tmp_val}" =~ ${REG_MATCH} ]]; do # validação REGEX
# #         echo "O IP informado nao corresponde ao ambiene solicitado"
# #         __read_value_s_time $FINAL_ENV  #"$TEXT"
# #     done
# # }
# # ansible all -i ../inventario/invent_teste.yml --list-hosts > /tmp/servers.txt
# # ansible-inventory --list -i ../inventario/invent_teste.yml  | jq -r 'map_values(select(.hosts != null and (.hosts ))) | keys[]' >  /tmp/groups.txt

# SERVERS_INVENT=$(ansible all -i ../inventario/invent_teste.yml --list-hosts)
# GROUPS_SERVERS_INVENT=$(ansible-inventory --list -i ../inventario/invent_teste.yml  | jq -r 'map_values(select(.hosts != null and (.hosts ))) | keys[]')
# PATTERN="[a-z]+"

# echo -n "digite o nome do servidor ou groupo de servers : "
# read node
# echo $SERVERS_INVENT | grep $node
# #if [[ $node =~ $PATTERN ]]; then 
#   for servers in $SERVERS_INVENT; do #(cat /tmp/servers.txt);
#     if [[ $(echo ${SERVERS_INVENT[@]} | grep "$node") ]];then 
#       echo você escolheu apenas o servidor "$servers" | grep $node | sort | uniq

#   for groups_servers in $GROUPS_SERVERS_INVENT  #(cat /tmp/groups.txt);
#     do
#     echo Você escolheu o grupo de servidores  "$groups_servers"  | grep $name             
#   done; 

#     else 
#       echo "server $node escolhido não é um server" && exit 0
#     fi   
#   done

# #   for groups_servers in $GROUPS_SERVERS_INVENT  #(cat /tmp/groups.txt);
# #     do
# #     echo Você escolheu o grupo de servidores  "$groups_servers"  | grep $name             
# #   done;  

# # else 
# #     echo "Escolha do $name incorreta valide no inventário o que deseja fazer"
# # fi



# # if [[ $(echo ${array[@]} | fgrep -w $value) ]]
# # then
# #   echo "value found"
# # else
# #   echo "value not found"
# # fi