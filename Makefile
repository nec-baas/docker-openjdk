NAME = necbaas/openjdk:11.0.6

all: image

Dockerfile: Dockerfile.in
	@if [ -n "$(http_proxy)" ]; then \
	    cat Dockerfile.in | sed "s|%%PROXY_URL%%|$(http_proxy)|" | sed "s|# proxy||" > Dockerfile; \
	else \
	    grep -v "# proxy" Dockerfile.in > Dockerfile; \
	fi

image: Dockerfile
	docker build -t $(NAME) .

clean:
	-/bin/rm Dockerfile

rmi:
	docker image rm $(NAME)

bash:
	docker container run -it --rm $(NAME) /bin/bash

start:
	docker container run -d $(PORT_OPTS) $(VOLUME_OPTS) $(NAME)

push:
	docker image push $(NAME)
