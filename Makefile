IMAGE_TAG=2.3                                                                                                                                                                                            
PORT=8888
CONATINER_NAME=jupyter


dirs=$(shell ls -d */ |cut -f1 -d '/')
last_dir=$(shell ls -d */ |cut -f1 -d '/' |tail -n1)
build:
	@echo 'building docker image'
	@$(foreach dir,$(dirs),docker build -t $(dir) $(dir);)
	@docker tag $(last_dir) $(last_dir):$(IMAGE_TAG)

build-force:
	@echo 'building docker image'
	@$(foreach dir,$(dirs),docker build --no-cache -t $(dir) $(dir);)
	@docker tag $(last_dir) $(last_dir):$(IMAGE_TAG)

clean:
	@docker stop $(CONTAINER_NAME)
	@docker rm $(CONTAINER_NAME)
	

test:
	@echo $(last_dir)

run:
	@docker run -d -p $(PORT):$(PORT) --name $(CONTAINER_NAME) $(last_dir):$(IMAGE_TAG) 
	
run_attach:
	@docker run -it -p $(PORT):$(PORT) --name $(CONTAINER_NAME) $(last_dir):$(IMAGE_TAG) 
