# Выполнение ДЗ | План работы

## Работа с тестовым веб-приложением

 - [x] Добавление проверок Pod
 - [x] Создание объекта Deployment
 - [x] Добавление сервисов в кластер ( ClusterIP )
 - [x] Включение режима балансировки IPVS

## Доступ к приложению извне кластера

 - [x] Установка MetalLB в Layer2-режиме
 - [x] Добавление сервиса LoadBalancer
 - [ ] Установка Ingress-контроллера и прокси ingress-nginx
 - [ ] Создание правил Ingress


## Deployment | Самостоятельная работа

### rollingUpdate strategy

|  | maxUnavailable | maxSurge | RESULT |
|---|---|---|---|
| 1. | 0 | 0 | invalid: `maxUnavailable` may not 0 when `maxSurge` is 0 |
| 2. | 0 | 100% | `MinimumReplicasUnavailable : FALSE`<br>`ReplicaSetUpdated : TRUE` |
| 3. | 100% | 0 | `MinimumReplicasUnavailable : TRUE`<br>`ReplicaSetUpdated : TRUE` |
| 4. | 100% | 100% | `MinimumReplicasUnavailable : TRUE`<br>`ReplicaSetUpdated : TRUE` |
