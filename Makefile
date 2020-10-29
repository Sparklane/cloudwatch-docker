.PHONY: all
NAME ?= aws-cloudwatch
VERSION ?= latest
REGISTRY ?= ""

all: build publish

build:
	@docker build -t $(NAME):$(VERSION) \
	--rm=true .

publish: build
	@docker tag $(NAME):$(VERSION) $(REGISTRY)/$(NAME):$(VERSION)
	@docker push $(REGISTRY)/$(NAME):$(VERSION)

run:
	@docker run --rm -d --name $(NAME) \
		-e OPTIONS="--mem-util --swap-util --disk-space-util --disk-path=/data" \
		-e CRON="* * * * *" \
		$(REGISTRY)/$(NAME)

stop:
	@docker rm -f $(NAME)
