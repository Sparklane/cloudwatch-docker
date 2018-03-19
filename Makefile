.PHONY: all
VERSION ?= latest

all: build publish

build:
	@docker build -t sparklane/cloudwatch .

run:
	@docker run --rm -d --name cloudwatch \
		-e OPTIONS="--mem-util --swap-util --disk-space-util --disk-path=/data" \
		-e CRON="* * * * *" \
		sparklane/cloudwatch

stop:
	@docker rm -f cloudwatch
