Prometheus => 
Ele usado para monitorar o desempenho e a saúde dos clusters, bem como para fornecer informações sobre o comportamento dos aplicativos implantados em um ambiente de contêineres.

O Prometheus Operator é uma ferramenta de automação open-source para Kubernetes que simplifica a implantação e gerenciamento do servidor Prometheus e seus componentes relacionados, como o Alertmanager, Grafana e o próprio Operator.

O Prometheus Operator simplifica a configuração do Prometheus, permitindo que os usuários definam as configurações de coleta de métricas, alertas e retenção de dados usando arquivos YAML declarativos. Além disso, o Operator oferece recursos de auto-escalonamento e auto-recuperação, o que significa que ele pode dimensionar automaticamente o número de replicas do servidor Prometheus e reiniciar componentes falhos.

Prometheus Operator é que ele simplifica a implantação de alertas e regras de monitoramento. Em vez de configurar manualmente regras de alerta, o Operator pode monitorar automaticamente as métricas de serviço e criar alertas com base em regras pré-definidas. Isso pode economizar tempo e minimizar erros na configuração de alertas.



prometheus-adapter
blackbox-exporter
grafana
kube-state-metrics
prometheus-operator



kubectl apply -f components_metrics.yaml -n kube-system
kubectl create -f manifests/setup 
kubectl apply -f manifests/


 kubectl -n monitoring port-forward svc/prometheus-k8s 9090:9090
O que é o Blackbox Exporter
O Blackbox Exporter é usado para sondar pontos de extremidade como HTTPS, HTTP, TCP, DNS e ICMP. Depois de definir o ponto de extremidade, 
o Blackbox Exporter gera métricas que podem ser visualizadas usando ferramentas como o Grafana.
 Uma das características mais importantes do Blackbox Exporter é medir o tempo de resposta dos endpoints.

Add 
connectors:
https://tcpterminal2.webhook.office.com/webhookb2/c0128a7e-935e-4844-88d4-488ac5bd0fbc@3a9a0a2c-2be4-47c7-a658-e5ef533ce4e2/IncomingWebhook/00b9b2296122445b9a369ea7d561da7d/db300727-e505-47c1-8061-b9ccd80bcf4a


 export HELM_DRIVER=configmap; helm repo add prometheus-msteams https://prometheus-msteams.github.io/prometheus-msteams/

 export HELM_DRIVER=configmap; helm upgrade --install prometheus-msteams \
  --namespace monitoring -f values.yaml \
  prometheus-msteams/prometheus-msteams

  ----
  add nos yml alert managers
  +++++
            config:
            #By default you can override default receiver as well 
            default_receiver: msteams-alerts
            receivers: |
              - name: msteams-alerts
                webhook_configs:
                  - send_resolved: true
                    url: 'http://prometheus-msteams.kublr:2000/msteams-alerts'

+++++++                    


Livro descomplicando Prometheus: https://github.com/badtuxx/DescomplicandoPrometheus

Aplicar esses três pontos: 

Logs


Metrics -> > Prometheus


Traces


Eventos


Dashboards

Logs -> OpenSearch 
Métricas -> Prometheus
Traces -> Jaeger ou eBPF
Eventos -> Zabbix ou Datadog
Visualização/Dashboards -> Grafana, Datadog ou Pixie

Componentes Prometheus 
Retrieval
Storage
PromQL
Metrics -> > Prometheus

O Retrieval é o responsável por coletar as métricas e conversar com o Storage para armazená-las. É o Retrieval também o responsável por conversar com o Service Discovery para encontrar os serviços que estão disponíveis para coletar métricas.

Já o Storage é o responsável por armazenar as métricas no TSDB, lembre-se que o TSDB é um time series database, super importante para otimizar a performance de coleta e leitura das métricas. Importante lembrar que o Storage armazena as métricas no disco local do node que ele está sendo executado. Com isso, caso você esteja com o Prometheus instalado em uma VM, os dados serão armazenados no disco local da VM.

O PromQL é o responsável por executar as queries do usuário. Ele é o responsável por conversar com o Storage para buscar as métricas que o usuário deseja. O  PromQL é uma riquíssima linguagem de consulta, ela não é parecida com outras linguagens de consulta como o SQL, por exemplo.

