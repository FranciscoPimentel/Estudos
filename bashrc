# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME=powerlevel10k/powerlevel10k

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions fzf)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /home/francisco/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/powerlevel10k/config/p10k-rainbow.zsh.
[[ ! -f ~/powerlevel10k/config/p10k-rainbow.zsh ]] || source ~/powerlevel10k/config/p10k-rainbow.zsh

##Alias Francisco
alias tcp='cd /media/francisco/media/GIT/tcp/'
alias l='ls -la -tr'
alias k='kubectl'
alias k8s_teste='export KUBECONFIG=/home/francisco/.kube/teste.conf'
alias qa_cluster='export KUBECONFIG=/home/francisco/.kube/qa_config'
alias prd_cluster='export KUBECONFIG=/home/francisco/.kube/prd-worker_config'
alias krewk8s='export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"'
##Alias TCP Server 

#### Pass: 1q2w3e!Q@W#E
##Alias HaProxy
#IP virtual: 10.41.12.29
alias qa-haproxy_1='ssh infra@10.41.12.118'
alias qa-haproxy_2='ssh infra@10.41.12.119'

##Alias cluster testes K8s Masters
alias k8s_qa-master_1='ssh infra@10.41.12.107'
alias k8s_qa-master_2='ssh infra@10.41.12.108'
alias k8s_qa-master_3='ssh infra@10.41.12.109'

##Alias cluster testes K8s Slaves
alias k8s_qa-worker_1='ssh infra@10.41.12.110'
alias k8s_qa-worker_2='ssh infra@10.41.12.111'
alias k8s_qa-worker_3='ssh infra@10.41.12.112'
alias k8s_qa-worker_4='ssh infra@10.41.12.113'
alias k8s_qa-worker_5='ssh infra@10.41.12.114'
alias k8s_qa-worker_6='ssh infra@10.41.12.115'
alias k8s_qa-worker_7='ssh infra@10.41.12.116'
alias k8s_qa-worker_8='ssh infra@10.41.12.117'

##Alias cluster testes MongoDB
alias qa-mongodb_1='ssh infra@10.41.12.135'
alias qa-mongodb_2='ssh infra@10.41.12.136'
alias qa-mongodb_3='ssh infra@10.41.12.137'

#### Pass: 1q2w3e!Q@W#E
##Alias HaProxy
#IP virtual: 10.41.12.219
alias qa-app-haproxy_1='ssh infra@10.41.12.204'
alias qa-app-haproxy_2='ssh infra@10.41.12.205'

##Alias cluster testes RabbitMq
alias qa-rabbitmq_1='ssh infra@10.41.12.132'
alias qa-rabbitmq_2='ssh infra@10.41.12.133'
alias qa-rabbitmq_3='ssh infra@10.41.12.134'

##Alias cluster testes Redis
alias qa-redis_1='ssh infra@10.41.12.206'
alias qa-redis_2='ssh infra@10.41.12.207'
alias qa-redis_3='ssh infra@10.41.12.208'

##StorageVolumeCluster
alias k8s_qa-volume='ssh infra@10.41.12.26'

## Servidor de backup CEPH e Velero
alias racktables='ssh infra@10.41.12.56' ## Pedir para matar essa VM

##Openseach
alias qa-opensearch-1='ssh infra@10.41.12.72'
alias qa-opensearch-2='ssh infra@10.41.12.58'
alias qa-opensearch-dash='ssh infra@10.41.12.59'
alias qa-opensearch-manager='ssh infra@10.41.12.66'

##Alias Harbor rede 9 PRODUÇÃO
##1q2w3e!Q@W#E
alias goharbor='ssh infra@10.41.9.12' #PRODUÇÃO
alias goharbor2='ssh infra@10.41.9.13' #PRODUÇÃO
alias goharbor3='ssh infra@10.41.9.14' #PRODUÇÃO
alias goproxy='ssh infra@10.41.9.15' #PRODUÇÃO

##Alias Harbor
##1q2w3e!Q@W#E
alias teste1='ssh infra@10.41.13.212'
alias teste2='ssh infra@10.41.13.213'
alias teste3='ssh infra@10.41.13.214'
alias teste4='ssh infra@10.41.13.75'

##Alias ambiente QA2 ctosteam 
##8pBRqFDcOidBLKe7WpeG
#kubernetes
alias k8s_ctos-master="ssh ctosteam@10.41.6.21"
alias k8s_ctos-node1="ssh ctosteam@10.41.6.22"
alias k8s_ctos-node2="ssh ctosteam@10.41.6.23"
alias k8s_ctos-node3="ssh ctosteam@10.41.6.24"
alias k8s_ctos-node4="ssh ctosteam@10.41.6.25"
#NFS
alias k8s_ctos-nfs="ssh ctosteam@10.41.6.26"
#haproxy
alias ctos-haproxy="ssh ctosteam@10.41.6.27"
#mongodb
alias ctos-mongodb="ssh ctosteam@10.41.6.28"
#rabbitmq
alias ctos-rabbitmq="ssh ctosteam@10.41.6.29"
#redis
alias ctos-redis="ssh ctosteam@10.41.6.30"

## Ambiente PRD Worker
#1q2w3e!Q@W#E
# Haproxy = Ip virtual 10.41.5.12 
alias prod-haproxy_1='ssh infra@10.41.5.10'
alias prod-haproxy_2='ssh infra@10.41.5.11'

# K8s Master
alias k8s_prod-master_1='ssh infra@10.41.5.20'
alias k8s_prod-master_2='ssh infra@10.41.5.21'
#alias k8s_prod-master_3='ssh infra@10.41.5.22' #VM Deu problema pedir para remover 
alias k8s_prod-master_3='ssh infra@10.41.5.23'  
# Workers
alias k8s_prod-worker_1='ssh infra@10.41.5.33'
alias k8s_prod-worker_2='ssh infra@10.41.5.34'
alias k8s_prod-worker_3='ssh infra@10.41.5.35'
alias k8s_prod-worker_4='ssh infra@10.41.5.36'
alias k8s_prod-worker_5='ssh infra@10.41.5.37'
alias k8s_prod-worker_6='ssh infra@10.41.5.38'
# Redis 
alias redis_prod-worker_1='ssh infra@10.41.5.43'
alias redis_prod-worker_2='ssh infra@10.41.5.44'
alias redis_prod-worker_3='ssh infra@10.41.5.45'
# OpenSearch
alias prd-opensearch_dash-coord='ssh infra@10.41.5.54' #VPLNX0003
alias prd_opensearch_manager-1='ssh infra@10.41.5.55' #VPLNX0004
#alias prd_opensearch_manager-2='ssh infra@10.41.5.56'
alias prd-opensearch-data-1='ssh infra@10.41.5.57' #VPLNX0006
alias prd-opensearch-data-2='ssh infra@10.41.5.58' #VPLNX0007

##CTOS -2 

alias CTOSQA-haproxy-01='ssh infra@10.41.12.14'
alias CTOSQA-MongoDB='ssh infra@10.41.12.15'
alias CTOSQA-OpensearchData='ssh infra@10.41.12.16'
alias CTOSQA-OpensearchManager='ssh infra@10.41.12.17'
alias CTOSQA-Rabbitmq='ssh infra@10.41.12.18'
alias CTOSQA-Redis='ssh infra@10.41.12.19'
alias K8SCTOSQA-haproxy-01='ssh infra@10.41.12.20'
alias K8SCTOSQA-Master='ssh infra@10.41.12.74'
alias K8SCTOSQA-Worker-01='ssh infra@10.41.12.75'
alias K8SCTOSQA-Worker-02='ssh infra@10.41.12.76'
alias K8SCTOSQA-Worker-03='ssh infra@10.41.12.77'
alias K8SCTOSQA-Worker-04='ssh infra@10.41.12.78'


##Kubernetes
#alias k='kubectl'
#source <(kubectl completion zsh) # set up autocomplete in zsh into the current shell
#echo '[[ $commands[kubectl] ]] && source <(kubectl completion zsh)' >> ~/.zshrc # add autocomplete permanently to your zsh shell#

#[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
#[
