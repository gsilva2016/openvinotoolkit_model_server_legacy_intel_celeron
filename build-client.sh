#!/bin/bash

if [ "$1" = "from_binary" ]
then
	docker build -f Dockerfile.tensorflow-build-binary . -t benchmark_client

else
	# build tensorflow for legacy celeron
	docker build -f Dockerfile.build-tensorflow-legacy-celeron . -t build-tensorflow-legacy-celeron
	docker build -f Dockerfile.tensorflow-build-src . -t benchmark_client
fi
