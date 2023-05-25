import sys, os, string
import paramiko
# variaveis de conexão
addresses = input("add o IP: ") 
username = input("username: ")
key = paramiko.RSAKey.from_private_key_file('/home/jose/.ssh/id_rsa')

# Conexão.
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(hostname=addresses, username=username, pkey=key)

# Execução de comandos 
stdin, stdout, stderr = ssh.exec_command('docker version')
stdin.close()
for line in stdout.readlines():
    print(line.replace ('\n',''), end='.00 \n' .format( 3 ))

import paramiko
import os
from tqdm import tqdm

# Ler lista de IPs e comandos
with open('ip_list.txt', 'r') as f:
    ip_list = [line.strip() for line in f]

with open('commands.txt', 'r') as f:
    commands = [line.strip() for line in f]

# Dados de autenticação SSH
username = 'morcego'
password = 'admin@123'

# Criar diretórios para IPs com falhas
os.makedirs('failed_auth_ips', exist_ok=True)
os.makedirs('failed_connection_ips', exist_ok=True)

# Função para executar comandos SSH
def run_ssh_commands(ip, commands, username, password, failed_auth_ips, failed_connection_ips):
    try:
        with paramiko.SSHClient() as client:
            client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            client.connect(ip, port=22, username=username, password=password, timeout=5)

            with open(f'{ip}.txt', 'w') as f:
                for command in commands:
                    stdin, stdout, stderr = client.exec_command(command)
                    f.write('\n' + '-'*70 + '\n')
                    f.write(f'{command}\n')
                    f.write(stdout.read().decode('utf-8'))
                    f.write('-'*70 + '\n')
                    f.write('\n')

            print(f'[+] {ip}:22 - Conexão SSH aberta')

    except paramiko.ssh_exception.AuthenticationException:
        print(f'[-] {ip}:22 - Autenticação falhou')
        failed_auth_ips.append(ip)
    except paramiko.ssh_exception.NoValidConnectionsError:
        print(f'[-] {ip}:22 - Nenhuma conexão válida')
        failed_connection_ips.append(ip)
    except Exception as e:
        print(f'[-] {ip}:22 - Não foi possível executar comandos em {ip}:22')
        print(e)
        failed_connection_ips.append(ip)

# Loop pelos endereços IP
failed_auth_ips = []
failed_connection_ips = []
for ip in tqdm(ip_list):
    run_ssh_commands(ip, commands, username, password, failed_auth_ips, failed_connection_ips)

# Salvar IPs com falhas de autenticação e conexão em arquivos nos diretórios correspondentes
with open('failed_auth_ips/failed_auth_ips.txt', 'w') as f:
    for ip in failed_auth_ips:
        f.write(ip + '\n')

with open('failed_connection_ips/failed_connection_ips.txt', 'w') as f:
    for ip in failed_connection_ips:
        f.write(ip + '\n')

    
#stdin, stdout, stderr = ssh.exec_command('uptime')
#stdin.close()
#for line in stdout.readlines():
#    print(line.replace ('\n',''), end='.00 \n')
    
# Executando o UPDATE

#stdin, stdout, stderr = ssh.exec_command('docker service ls\n')
#stdin.close()
#for line in stdout.readlines():
#    print(line.replaces ('\n',''), end='.00 \n' .format( 4 ))

# Executando o UPGRADE
#
#stdin, stdout, stderr = ssh.exec_command('apt-get upgrade\n')
#stdin.write('y\n')
#stdin.flush()
#print(stdout.readlines())
#ssh.close()