#!/bin/bash

# function __read_value()
# {
#     FINAL_ENV=$1
#     REG_MATCH=$2
#     TEXT=$3
#     SERVERS_INVENT=$(ansible all -i inventario/invent_teste.yml --list-hosts)
#     GROUPS_SERVERS_INVENT=$(ansible -i inventario/invent_teste.yml workers -m debug -a "var=groups")

#     __read_value_s_time $FINAL_ENV  "$TEXT"

#     while ! [[ "${tmp_val}" =~ ${REG_MATCH} ]]; do # validação REGEX
#         echo "O IP informado nao corresponde ao ambiene solicitado"
#         __read_value_s_time $FINAL_ENV  #"$TEXT"
#     done
# }
# ansible all -i ../inventario/invent_teste.yml --list-hosts > /tmp/servers.txt
# ansible-inventory --list -i ../inventario/invent_teste.yml  | jq -r 'map_values(select(.hosts != null and (.hosts ))) | keys[]' >  /tmp/groups.txt

SERVERS_INVENT=$(ansible all -i ../inventario/invent_teste.yml --list-hosts)
GROUPS_SERVERS_INVENT=$(ansible-inventory --list -i ../inventario/invent_teste.yml  | jq -r 'map_values(select(.hosts != null and (.hosts ))) | keys[]')
#ALL_GROUPS_SERVERS=$(ansible-inventory --list -i ../inventario/invent_teste.yml | jq -r 'map_values(select(.hosts != null and (.hosts )))' | grep -v hosts)
PATTERN="[a-z]+"

echo -n "digite o nome do servidor ou groupo de servers : "
read node
echo $SERVERS_INVENT | grep $node
if [[ $node =~ $PATTERN ]]; then
  for servers in $SERVERS_INVENT
    do
      echo você escolheu apenas o servidor "$servers" | grep -w $node | sort | uniq
  done
#
  for groups_servers in $GROUPS_SERVERS_INVENT
    do
    echo Você escolheu o grupo de servidores  "$groups_servers"  | grep -w $node
  done;
else [[ ]]  


## metodo função recebe lista que recebe um outro parametro que tipo um contains 
#
  # for all_servers in $ALL_GROUPS_SERVERS
  #   do
  # elif [[ $(echo ${ALL_GROUPS_SERVERS[@]} | grep "$node") ]]
  #   then
  #   echo O que vc escolheu não existe $ALL_GROUPS_SERVERS | grep -w $node
  # done;
#
else
     echo "Não é aceito número de IP, neste caso o  $node, deverá ser incluso corretamente no inventário"
fi

