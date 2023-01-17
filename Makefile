USER "$(shell id -u):$(shell id -u)"

APP_NAME := kuber-2022-12
APP_VER := 0.0.2-nginx

build:
	docker build -t kaperusov/$(APP_NAME):$(APP_VER) ./app

run: 
	docker run --name $(APP_NAME) -dp 8000:8000 kaperusov/$(APP_NAME):$(APP_VER)

exec:
	docker exec -it $(APP_NAME) sh

stop:
	docker stop $(APP_NAME) 

clean:	
	docker rm $(APP_NAME)

push:
# docker login
	docker push kaperusov/$(APP_NAME):$(APP_VER)



# -----------------------------------------------------------------------------
MS_NAME := 
MS_VER := v0.0.1

ms:
	@echo vars : $(MS_NAME) : $(MS_VER)
	docker build -t kaperusov/$(MS_NAME):$(MS_VER) ./microservices/src/$(MS_NAME)
#	docker push kaperusov/$(MS_NAME):$(MS_VER)

frontend:
	make ms MS_NAME=frontend MS_VER=$(MS_VER)

paymentservice:
	make ms MS_NAME=paymentservice MS_VER=$(MS_VER)
