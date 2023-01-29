# ДЗ №03

## Работа с тестовым веб-приложением

 - [x] Добавление проверок Pod
 - [x] Создание объекта Deployment
 - [x] Добавление сервисов в кластер ( ClusterIP )
 - [x] Включение режима балансировки IPVS

## Доступ к приложению извне кластера

 - [x] Установка MetalLB в Layer2-режиме
 - [x] Добавление сервиса LoadBalancer
 - [x] Установка Ingress-контроллера и прокси ingress-nginx
 - [x] Создание правил Ingress


## Deployment | Самостоятельная работа

### rollingUpdate strategy

|  | maxUnavailable | maxSurge | RESULT |
|---|---|---|---|
| 1. | 0 | 0 | invalid: `maxUnavailable` may not 0 when `maxSurge` is 0 |
| 2. | 0 | 100% | `MinimumReplicasUnavailable : FALSE`<br>`ReplicaSetUpdated : TRUE` |
| 3. | 100% | 0 | `MinimumReplicasUnavailable : TRUE`<br>`ReplicaSetUpdated : TRUE` |
| 4. | 100% | 100% | `MinimumReplicasUnavailable : TRUE`<br>`ReplicaSetUpdated : TRUE` |


## Kubernetes Dashboard

```shell
# Create k8s dashboard
kubectl apply -f ./dashboard/dashboard-deploy.yaml

# Create token for access:
kubectl --namespace kubernetes-dashboard create token  kubernetes-dashboard

# Create custom service account + token:
kubectl apply -f ./dashboard/admin-sa.yml
kubectl apply -f ./dashboard/admin-rbac.yml
kubectl --namespace kube-system create token kube-admin
```

Чтобы проверить, что оно вообще работает:
```shell
kubectl proxy
```

Затем перейти по URL: 

  http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/


Для доступа к Dashboard через Ingress службу, надо создать:

```shell
# 1. ClusterIP None service (?? или лучше TCP/UDP сервисы ??)
kubectl apply -f ./dashboard/dashboard-svc-headless.yaml
# 2. Ingress для dashboard-svc --^
kubectl apply -f ./dashboard/dashboard-ingress.yaml
```

Как это проверить, я не знаю. Nginx Ingress в Minikube не выдаёт мне IP адреса:

```
>$ kubectl get ing -A
NAMESPACE              NAME        CLASS    HOSTS                   ADDRESS   PORTS   AGE
default                web         <none>   minikube.web-svc.io               80      145m
kubernetes-dashboard   dashboard   <none>   minikube.dashboard.io             80      9m21`s
```

Для решения этой проблемы везде советуют применить
```
minikube addons enable ingress
```

Но это тоже не сильно помогает... 

А точнее совсем не помогает: 

```
stderr:
Error from server (Invalid): error when applying patch:
... omitted ... 

╭───────────────────────────────────────────────────────────────────────────────────────────╮
│                                                                                           │
│    😿  If the above advice does not help, please let us know:                             │
│    👉  https://github.com/kubernetes/minikube/issues/new/choose                           │
│                                                                                           │
│    Please run `minikube logs --file=logs.txt` and attach logs.txt to the GitHub issue.    │
│    Please also attach the following file to the GitHub issue:                             │
│    - /tmp/minikube_addons_fb41bf742de9ca7b7057d6941c03dbd2cc588e5d_0.log                  │
│                                                                                           │
╰───────────────────────────────────────────────────────────────────────────────────────────╯
```



## Canary

.... 



## minikube tunnels


```shell
ssh -i $(minikube ssh-key) docker@$(minikube ip) -L 8008:localhost:80
minikube service web-svc-lb --url
minikube service dns-service-tcp --url
minikube service --namespace=kubernetes-dashboard dashboard-svc --url
minikube service --namespace=kubernetes-dashboard dashboard-tcp --url
```
