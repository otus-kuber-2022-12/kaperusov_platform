# ДЗ №03

## Для создания секрета к MinIO нужно выполнить следующую комаду:

```shell
kubectl create secret generic minio-secret \
    --from-literal=accessKey='minio' \
    --from-literal=secretKey='minio123'
```

или воспользоваться скриптом: 

```shell
./create-secret.sh
```

После этого создать сам StatefulSet:

```shell
kubectl apply -f minio-statefulset.yaml
```
