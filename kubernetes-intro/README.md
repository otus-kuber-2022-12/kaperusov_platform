# ДЗ №01

## Задание №1

> Разберитесь почему все pod в namespace kube-system восстановились после удаления. Укажите причину в описании PR

Несколько причин. 

Для coredns это наличие контроллера репликаций, в лице coredns deployement, 
который следит за количеством реплик в кластере и пытается восстановить их если они уменьшаются. 
Например, если выполнить команду `kubectl describe deploy -n kube-system coredns`
мы можем увидеть подобное сообщение
`NewReplicaSet:   coredns-565d847f94 (1/1 replicas created)`

kube-apiserver запускается как статический pod, которыми напрямую управляет kubelet daemon читая
их конфигурации из директории `/etc/kubernetes/manifests/`, там можно найти такие файлы: 
  - etcd.yaml
  - kube-apiserver.yaml 
  - kube-controller-manager.yaml
  - kube-scheduler.yaml

Эти конфигурации создаются при инициализации кластера, после чего kubelet daemon постояно следит 
за изменениями в них и пересоздаёт в случае обнаружения изменений, а также восстанавливает, если поды 
по каким-то причинам были остановлены. 

## Содержимое проекта

### web/

В папке web находится тестовый проект созданый с помощью [Hugo](https://gohugo.io/), в котором я тренировался 
с запуском своего web-сервера на порту 8000 следуюя инструкциям ДЗ (стр.17).

Образ полученный из файла web/Dockerfile загружен в мой [Docker Hub](https://hub.docker.com/repository/docker/kaperusov/kuber-2022-12/general) 
в тэги 0.0.1 и 0.0.2.

### app/

В папке app находится совсем простой образ с [nginx](https://hub.docker.com/r/nginxinc/nginx-unprivileged), 
в который я поместил тестовую статическую HTML страницу, а также использовал его 
для работы с Init контейнером.

Для запуска нужно воспользоваться следующими командами:

```shell
kubectl apply -f kubernetes-intro/web-pod.yaml
kubectl port-forward --address 0.0.0.0 pod/web 8080:8080
```

После чего перейти по ссылке: [localhost:8080](localhost:8080)

## Задание со ⭐

> Выясните причину, по которой pod frontend находится в статусе Error

Проблема в том, что при формировании yaml файла с помощью команды:

```shell
kubectl run frontend --image avtandilko/hipster-frontend:v0.0.1 --restart=Never --dry-run -o yaml > frontend-pod-healthy.yaml
```

в полученном манифесте отсутствуют переменные окружения, необходимые для работы контейнера.

Добавление в манифест недостающей секции `env` исправило ошибку: 

```yaml
    env:
      - name: PORT
        value: "8080"
      - name: PRODUCT_CATALOG_SERVICE_ADDR
        value: "productcatalogservice:3550"
      - name: CURRENCY_SERVICE_ADDR
        value: "currencyservice:7000"
      - name: CART_SERVICE_ADDR
        value: "cartservice:7070"
      - name: RECOMMENDATION_SERVICE_ADDR
        value: "recommendationservice:8080"
      - name: SHIPPING_SERVICE_ADDR
        value: "shippingservice:50051"
      - name: CHECKOUT_SERVICE_ADDR
        value: "checkoutservice:5050"
      - name: AD_SERVICE_ADDR
        value: "adservice:9555"
```

