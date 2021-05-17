.PHONY: all
NAME ?= aws-cloudwatch
VERSION ?= latest
REGISTRY ?= ""
CLOUDWATCH_MONITORING_SCRIPTS_ZIP_URL ?= "https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip"

all: build publish

build:
	@docker build -t $(NAME):$(VERSION) \
		--build-arg CLOUDWATCH_MONITORING_SCRIPTS_ZIP_URL=$(CLOUDWATCH_MONITORING_SCRIPTS_ZIP_URL) \
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
