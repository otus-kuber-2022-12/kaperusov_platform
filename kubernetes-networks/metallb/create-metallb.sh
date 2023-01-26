#!/bin/bash
kubectl apply -f namespace.yaml
kubectl apply -f metallb.yaml

kubectl create secret generic \
    -n metallb-system memberlist \
    --from-literal=secretkey="$(openssl rand -base64 128)" \
    -o yaml --dry-run=client > metallb-secret.yaml

kubectl create --save-config -f metallb-secret.yaml

# show all
watch kubectl --namespace metallb-system get all
