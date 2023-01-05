USER "$(shell id -u):$(shell id -u)"

VERSION = "0.0.2"
NAME = "kuber-2022-12"

build:
	docker build -t kaperusov/$(NAME):$(VERSION) ./web

run: 
	docker run --name $(NAME) -dp 8000:8000 kaperusov/$(NAME):$(VERSION)

exec:
	docker exec -it $(NAME) sh

stop:
	docker stop $(NAME) 

clean:	
	docker rm $(NAME)

push:
	# docker login
	docker push kaperusov/$(NAME):$(VERSION)