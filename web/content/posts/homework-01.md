---
title: "Знакомство с Kubernetes, основные понятия и архитектура // ДЗ"
date: 2022-12-26T21:23:59+03:00
draft: false
---
## Установка Minikube

**Minikube** - наиболее универсальный вариант для развертывания
локального окружения.

Установим последнюю доступную версию Minikube на локальную
машину. 
Инструкции по установке доступны по [ссылке](https://kubernetes.io/docs/tasks/tools/install-minikube).


## Запуск Minikube

После установки запустим виртуальную машину с кластером Kubernetes
командой `minikube start`.

В зависимости от используемой операционной системы для успешного
старта могут потребоваться дополнительные флаги.

После запуска, Minikube должен автоматически настроить kubectl и
создать контекст minikube. Посмотреть текущую конфигурацию kubectl
можно командой `kubectl config view`.

Проверим, что подключение к кластеру работает корректно:

```shell
kubectl cluster-info
```

Вывод должен выглядеть следующим образом:
```shell
Kubernetes master is running at https://192.168.99.100:8443
KubeDNS is running at https://192.168.99.100:8443/api/v1/namespaces/kube-system/services/kube-
dns:dns/proxy
```

## Minikube

При установке кластера с использованием Minikube будет создана
виртуальная машина в которой будут работать все системные компоненты
кластера Kubernetes.

Можем убедиться в этом, зайдем на ВМ по SSH и посмотрим
запущенные Docker контейнеры:
```shell
minikube ssh
docker ps
```
Проверим, что Kubernetes обладает некоторой устойчивостью к
отказам, удалим все контейнеры:
```shell
docker rm -f $(docker ps -a -q)
```

## kubectl

Эти же компоненты, но уже в виде pod можно увидеть в `namespace kube-system`:

```shell
kubectl get pods -n kube-system
```

Расшифруем: данной командой мы запросили у API вывести список
(`get`) всех pod (`pods`) в namespace (`-n`, сокращенное от `--namespace`) `kube-system`.

Можно устроить еще одну проверку на прочность и удалить все pod с
системными компонентами:

```shell
kubectl delete pod --all -n kube-system
```

Проверим, что кластер находится в рабочем состоянии, команды:
```shell
kubectl get componentstatuses
```
или сокращенно:
```shell
kubectl get cs
```

выведут состояние системных компонентов:
```shell
NAME                 STATUS    MESSAGE                         ERROR
controller-manager   Healthy   ok                              
scheduler            Healthy   ok                              
etcd-0               Healthy   {"health":"true","reason":""}
```

