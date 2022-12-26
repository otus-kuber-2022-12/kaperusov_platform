USER "$(shell id -u):$(shell id -u)"

build:
	docker build -t hw-app:0.0.1 ./web

run: 
	docker run --name k8s-hw -dp 8000:8000 hw-app:0.0.1

exec:
	docker exec -it k8s-hw sh

stop:
	docker stop k8s-hw && docker rm k8s-hw
