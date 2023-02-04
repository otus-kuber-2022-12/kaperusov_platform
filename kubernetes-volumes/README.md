# ДЗ №04

## В процессе сделано:
 - Установка и запуск kind
 - Сформированы и применены yaml скрипты для создания MinIO StatefulSet и Headless Service
 - Настроена конфигурация для использования secrets

## Как проверить работоспособность:

Для создания секрета к MinIO нужно перейти в директорию `./secrets` 
и выполнить следующую команду:

```shell
kubectl create secret generic minio-secret \
	--from-literal=accessKey='minio' \
	--from-literal=secretKey='minio123'
```
или воспользоваться скриптом:
```shell
./create-secret.sh
```
После чего создать StatefulSet и Headless Services:
```shell
kubectl apply -f minio-statefulset.yaml
kubectl apply -f minio-headless-service.yaml
```

## Для роверки работоспособности 
выполнить port-forward:
```shell
kubectl port-forward --address 0.0.0.0 pod/minio-s-0 9000:9000
```
и перейти по ссылке http://localhost:9000

Для входа нужно ввести accessKey и secretKey указанные при создании minio-secret

## PR checklist:
 - [x] Выставлен label с темой домашнего задания

