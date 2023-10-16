## GoHarbor 

Documentação visa explicar sobre: estrutura, instalação, configuração do cluster Docker em SWARM e rotina de backup do Registry GoHarbor usando em PROD. 

### Funcionamento:
Um sever configurado o Haproxy para balancear as requisições para o registry.tcp.com.br.
O sistema de registry de imagens que está sendo usado é o GoHarbor versão v2.6.1, instalada através do docker e balanceada as imagens com o swarm.
O respositorio de imagens está em um disco atachado de 1TB em cada server e replicado e compartilhado através do GlusterFs.
Neste caso a estrutura está configurada conforme imagem abaixo:

![Fluxograma](/home/jose/Images/Harbor.png "Imagem Fluxograma").
### 1 - Estrutura 
#### 1.1 - Haproxy
Um servidor para balanceamento de requisições,usando as configurações abaixo:
Ip/Hostname:
10.41.9.15 = vbalancer01; \
Sistema Operacional Ubuntu = 22.04; \
Memória RAM = 4GB; \
vCPU = 4; \
HD = 100GB; \
Software: Haproxy
#### 1.2 -  GoHarbor
Três Vms 
Ips/Hostname:
10.41.9.12 = VDOPSHARBOR01.tcp.com.br; \
10.41.9.13 = VDOPSHARBOR02.tcp.com.br; \
10.41.9.14 = VDOPSHARBOR03.tcp.com.br; \
Sistema Operacional Ubuntu = 22.04; \
Memória RAM = 4GB; \ 
vCPU = 4; \
HD = 100GB; \ 
Disco atachado = 1TB \
Software: Docker/Goharbor. \
>  **Note:**
O Harbor é balanceado com o Docker Swarm e o storage com o Gluster. 
##  Configurações 
#### 2.1 - Conifgurações Haproxy
As configurações usadas para balancear as requisições para o Registry GoHarbor, Grafana, Prometheus, Portainer e status de requições do Haproxy, estão conforme abaixo:

https://registry.tcp.com.br => GoHarbor \
https://registry.tcp.com.br:9000 => Portainer \
https://registry.tcp.com.br:3000 => Grafana \
https://registry.tcp.com.br:9090 => Prometheus \
https://registry.tcp.com.br:1936 => Status do Haproxy


>  **Note:**
Foi configurado TLS no HaProxy para que os serviços respondam com HTTPS. 
Exemplo de configuração arquivo ./haproxy.yml

Configuração importante add os IPs/hostname nos hosts do sistema operacional /etc/hosts.
#### 3 - Conifgurações Sistema Operacional 
#### 3.1 - Ajustes nos servidores para hospedar aplicação do GoHarbor
3.1.1 - Add user no sudoers;
3.1.2 - Add servers no /etc/hosts;
3.1.3 - Add chave id_rsa.pub  > authorized_keys de cada server. 
#### 3.2 - Configuração do disco de 1TB onde ficar os dados do Harbor
3.2.1 - Listar os discos:  
`sudo fdisk -l`

3.2.3 - Configurar o disco para o sistema receber, no caso "/dev/sdb":\
`fdisk /dev/sdb`

3.2.4 - Formate a partição como ext4(padrão do Linux) \
`mkfs.ext4 /dev/sdb1`

3.2.5 - Montar o disco para o sistema reconhecer \
`mount /dev/sdb1 /data`

3.2.6 - Edite o arquivo `/etc/fstab` e insira o disco que foi montado no servidor, segue exemplo de entrada:

> /dev/sdb1       /data           ext4    defaults        0       1 
### 4 - GlusterFs:

O que é GlusterFs: \
GlusterFs é um aplicativo que possibilita o compartilhamento e sincronização de discos em diferentes servidores, neste caso um serve um ou mais servers percam a conexão o acesso ao repositorio ficará acessível pela aplicação Harbor.

Usamos o GlusterFs para armazenar o registry, database(PostegreSQL), certificados que são usados para a comunicação entres os PODS, Redis, Registry, e demais dados pertinentes á aplicação.

#### 4.1 - Instalação GlusterFs: \
4.1.2 - `sudo apt update` \
4.1.2 - `sudo apt install software-properties-common` \
4.1.3 - `sudo add-apt-repository ppa:gluster/glusterfs-7` \
4.1.4 - `sudo apt update` \
4.1.5 - `sudo apt install glusterfs-server` \
4.1.6 - `sudo systemctl enable --now glusterd` 

Para verificar se a instalação ocorreu corretamente execute o comando: \
`systemctl status glusterd`

O retorno do comando informará se o serviço está ativo exemplo: 

***<p style="color:green">active (running)</p>***

A versão que estamos usando é: \
***glusterfs 10.1***
 
#### 4.2 - Configurações GlusterFS

4.2.1 - Adicionar os servidores ao cluster de compartilhamento de arquivos:

Escolha um servidor para ser master e execute o comando: \
`sudo gluster peer probe <NOME OU IP DO SERVER - 02>` \
`sudo gluster peer probe <NOME OU IP DO SERVER - 03>` 
>  **Note:** No master que você escolheu não tem necessidade de rodar o comando descrito visto que ele será usando para inicio da criação do cluster. 

Caso ocorra queda do servidor master os demais servers continuaram funcionando normal, a própria aplicação escolherá outro server para ser master.

Comandos para validar se o cluster está ativo e criado com sucesso: \
`sudo gluster peer status` \
`sudo gluster pool list`

4.2.2 - Criando o nome do *volume*, número de réplicas e path do servers que compartilhando entre servidores, comando de exemplo: \
`sudo gluster volume create <NOME QUE DESEJA DAR AO CLUSTER> replica 3 MASTER-1:/PATH SLAVE-2:/PATH SLAVE-03:/PATH force` 

No comando acima vc deverá mudar os nomes: MASTER-1, SLAVE-2 e SLAVE-3 para o nome ou IP dos servers dispobinilizados pela INFRA e o PATH também deverá ser alterado, segue comando usado para o ambiente de GoHarbor em PROD: \
`sudo gluster volume create harbor replica 3 VHLNX6023:/data VHLNX6024:/data VHLNX6025:/data force` 

4.2.3 - Após criado o cluster, você deverá iniciar para que sistema comece a compartilhar e passamos montar o disco do registry, comando:
`sudo gluster volume start harbor` \ 
Comandos para validar a configuração: \
`sudo gluster volume status harbor`
Verificar ser todos os servers estã ONLINE. \

`sudo gluster volume info harbor`
Verificar o *Type* se está como *Replicate* e as *Bricks* se lista todos os servers configurados para compartilhar diretório. 

4.2.4 - Configurar diretório que será compartilhado entre os servers e também que receberá os dados da aplicação do Harbor, através do comando: \

`sudo mount -t glusterfs MASTER-1:/<NOME QUE DESEJA DAR AO CLUSTER> /<PATH>/<DIRETORIO QUE FICARÁ OS DADOS DA APLICAÇÃO>` 

`sudo mount -t glusterfs SLAVE-2:/<NOME QUE DESEJA DAR AO CLUSTER> /<PATH>/<DIRETORIO QUE FICARÁ OS DADOS DA APLICAÇÃO>` 

`sudo mount -t glusterfs SLAVE-3:/<NOME QUE DESEJA DAR AO CLUSTER> /<PATH>/<DIRETORIO QUE FICARÁ OS DADOS DA APLICAÇÃO>` 

Comandos que usamos para montar o ambiente: \
`sudo mount -t glusterfs vhlnx6023:/harbor /data/goharbor` \
`sudo mount -t glusterfs vhlnx6024:/harbor /data/goharbor` \
`sudo mount -t glusterfs vhlnx6025:/harbor /data/goharbor` 
>  **Note:** O comando descrito deverá ser executado em cada server. 

Após feito o mount você deverá configurar o SO para caso ocorra uma reinicialização do sistema o *mount* não se perca, para isto deverá criar um diretório ***srv.mount.d*** no diretório ***/etc/systemd/system/*** , feito a criação do diretório crie um arquivo chamado ***override.conf*** no diretório ***/etc/systemd/system/srv.mount.d/***, com o conteúdo: \
***[Unit]*** \
***<font color="gray">After=glusterfs-server.service</font>*** \
***<font color="gray">Wants=glusterfs-server.service</font>*** \


Feito os passos acima adicione o mount do GlusterFs no /etc/fstab dos servidores: \
`localhost:/harbor /data/goharbor glusterfs defaults,_netdev 0 0` \
A linha acima deverá ser inserida em todos os servers pertencentes ao cluster.
>  **Note:** Essa parte é muito importante, pois caso o server seja reinicializado ele não perderá o mapeamento feito. 

Finalizamos a configuração do GlusterFS, e ela está pronta para receber os dados da aplicação GoHarbor. 

Links usados: \
https://docs.gluster.org/en/main/Quick-Start-Guide/Quickstart/  
https://kifarunix.com/install-and-setup-glusterfs-on-ubuntu/ 
https://www.digitalocean.com/community/tutorials/\how-to-create-a-redundant-storage-pool-using-glusterfs-on-ubuntu-20-04 

Foi usado links de terceiros, pois existem passos mais detalhados que a documentação do GlusterFs. 

### 5 -  Docker 
5.1 - Instalação Docker \
Siga o link abaixo: \
https://docs.docker.com/engine/install/ubuntu/ \
A documentação está bem detalhada, por este motivo não descrevi os passos nesta DOC e é recomendado o uso da mesma.

5.2 Configuração do Docker:
As configurações abaixo são referente a log rotate do docker, adicionar no grupo SUDOERS o usuário do docker, PATH certificado da aplicação: 

5.2.1 - Configurando o log rotate do docker e add os servers como confiáveis para acesso ao registry:
Crie um arquivo chamado "daemon.json" no diretório "/etc/docker", exemplo de comando:
`sudo vim /etc/docker/daemon.json`
Adicionar o conteúdo abaixo:
```
{
        "debug" : true,
        "insecure-registries" : ["10.41.13.212","10.41.13.213","10.41.13.214","0.0.0.0"],
        "experimental" : true,
        "log-opts": {
          "max-size": "500m",
          "max-file": "3"
 }

}
``` 
> Nota: NA linhta *insecure-registries* você deverá adicionar os IPs que fazem parte do cluster, ou IPs externos para acessar o registry. 


5.2.2 - Configurando o config.json  adicionando os IPs do cluster swarm:
Crie um arquivo chamado "config.json" no diretório "/etc/docker", exemplo de comando:
`sudo vim /etc/docker/config.json`
Adicionar o conteúdo abaixo:
```
{
"proxies":
 {
   "default":
   {

     "noProxy": "*.tcp.com.br,vhlnx6023,vhlnx6024,vhlnx6025,127.0.0.0/8"
   }
 }
``` 
> Nota: na linha noProxy adicionar o domínio e os IPs relacionados ao cluster. 

5.2.3 - Adicionar o PATH do cerfificado para configuração do Harbor:


operacional:
Execute os comandos abaixo: \
`sudo groupadd docker` \
`sudo usermod -aG docker $USER`

5.2.4 - Adicionar os certificados no SO para o docker/aplicação reconhecer:
Criar o arquivo certs.d no diretório /etc/docker, após criado o arquivo entra na diretório cd /etc/docker/certs.d/ crie o arquivo registry.tcp.com.br, exemplos de comandos:
mkdir  /etc/docker/certs.d
mkdir  /etc/docker/certs.d/registry.tcp.com.br
Neste diretório inclua o certificado e sua chave, no caso do Harbor ficou desta forma: 

```
ls -la /etc/docker/certs.d/registry.tcp.com.br
-rw-r--r-- 1 root root 5384 Nov 22 13:05 tcp.com.br.crt
-rw-r--r-- 1 root root 1798 Nov 22 13:05 tcp.com.br.rsa
```
Importante: Na renovação dos certificados dever subsitituir os arquivos antigos pelos os novos.

GlusterFs instalado e configurado, Docker também e instalado, vamos para o tópico de instalação do GlusterFs que irá compartilhar a pasta que contém os dados do GoHarbor entre o cluster de arquivos:

6 - Iniciando o cluster em SWARM \
 Swarm é um recurso do Docker que fornece funcionalidades de orquestração de contêiner, incluindo clustering nativo de hosts do Docker e agendamento de cargas de trabalho de contêineres.

Para iniciar o serviço basta escolhe um nó que irá pertencer ao cluster e executar o comando abaixo: \
`sudo docker swarm init --advertise-addr "10.41.13.212"`


```
Swarm initialized: current node (oppa2dyfhrl4cn6u0jtj0frkl) is now a manager.
To add a worker to this swarm, run the following command:
    docker swarm join --token SWMTKN-1-2pvreayic8hqpphvpn5u2q98mom39fbfw8af4rtu2piva2bm3t-8su2yn596hp51o6vpke9afysb IP:2377
To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```


<img title="a title" alt="JOIN" src="/home/jose/Imagens/join-swarm.png"> 

![title](home/jose/Imagens/join-swarm.png)

> Nota: O IP 10.41.13.212 citado no exemplo acima deverá ser substituído pelo IP do servidor que está iniciando o Swarm.

O docker irá gerar uma chave, que deverá ser inserida nos demais nós que irão pertencer ao cluster 

Após o token gerado, copiar o token e executar nos demais nós, conforme exemplo:


Executado o comando descrito segue alguns comandos para você testar o os servers foram mapeados corretamente: \
`sudo docker node ls` \

A lista deverá retornar da seguinte forma:


Observer que o status é: "", para que os nós devam integrar ao cluster para que os nós fiquem acessíveis(Reachable) ao cluster, para realizar a ação citada execute o comando:

`sudo docker node promote <NOME DO NÓ>` \
`sudo docker node promote <NOME DO NÓ>`

Comandos úteis:
Verificar se o nó está acessível: \
`docker node inspect manager1 --format "{{ .ManagerStatus.Reachability }}"`

Exemplo de comando: \
`docker node inspect vhlnx6025 --format "{{ .ManagerStatus.Reachability }}"`
***<p style="color:blue"># reachable </p>***

Verificar se o nó está online: \
`docker node inspect manager1 --format "{{ .Status.State }}"` \

Exemplo de comando: \
`docker node inspect vhlnx6024 --format "{{ .Status.State }}"`
***<p style="color:blue"># ready </p>***

Listar os nós que fazem parte do cluster do Docker:
`docker node ls`

7 - Instalação do GoHarbor: 
sudo docker run -v /:/hostfs goharbor/prepare:v2.1.0 gencert -p /data/goharbor/cert


> :warning: **Warning:** Do not push the big red button.

> :memo: **Note:** Sunrises are beautiful.

> :bulb: **Tip:** Remember to appreciate the little things in life.

<p style="color:blue">Make this text blue.</p>
<font color="red">This text is red!</font>

<kbd>{c:yellow}Essa é uma frase com fundo escuro e texto amarelo{/c}</kbd>

/home/jose/Imagens/join-swarm.png