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



## minikube tunnel


```shell
ssh -i $(minikube ssh-key) docker@$(minikube ip) -L 8008:localhost:80
minikube service web-svc-lb --url
minikube service dns-service-tcp --url
minikube service --namespace=kubernetes-dashboard dashboard-tcp --url
```

## Kubernetes Dashboard

```shell
kubectl apply -f ./dashboard/dashboard-deploy.yaml
kubectl apply -f ./dashboard/dashboard-ingress.yaml
kubectl apply -f ./dashboard/admin-sa.yml
kubectl apply -f ./dashboard/admin-rbac.yml
kubectl --namespace kube-system create token kube-admin
kubectl proxy
```

Open URL:

http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
