#!/bin/bash

AK='minio'
SK=''

read -r -p "Enter MinIO access key [${AK}]: " ans ; [ -z "${ans}" ] && ans=${AK} || AK=${ans}
stty -echo
read -r -p "Secret key: " ans ; [ -z "${ans}" ] && ans=${SK} || SK=${ans}
stty echo
echo "" 

n=${#SK}
if [[ "${n}" -lt 8 || ${n} -gt 40 ]]; then
    echo "Secret key should be in between 8 and 40 characters."
    exit 1
fi

kubectl create secret generic minio-secret \
    --from-literal=accessKey="${AK}" \
    --from-literal=secretKey="${SK}"
