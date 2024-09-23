#!/bin/bash

if [ "$TF_IMAGE" = "" ] 
then 
	TF_IMAGE="tensorflow/build:2.13-python3.9"
fi

if grep -q "2.13-python3.9" <<<$TF_IMAGE; then
	PKG_NAME="tensorflow-2.13.1-cp39-cp39-linux_x86_64.whl"
elif grep -q "2.13-python3.10" <<<$TF_IMAGE; then
	PKG_NAME="tensorflow-2.13.1-cp310-cp310-linux_x86_64.whl"
fi

if [ "$PKG_NAME" = "" ]
then
	echo "ERROR: Unrecognized $TF_IMAGE specified for build"
	exit 1
fi

echo "$TF_IMAGE -- note the TF version and Python version"

if [ "$1" = "from_binary" ]
then
	docker build -f Dockerfile.tensorflow-build-binary . -t benchmark_client

elif [ "$1" = "build_tensorflow_only" ]
then
	# build tensorflow .whl pkg for legacy celeron
        docker build -f Dockerfile.build-tensorflow-legacy-celeron . -t build-tensorflow-legacy-celeron --build-arg TF_IMAGE="$TF_IMAGE"
	echo "Built  /wheels/tensorflow/$PKG_NAME"
else
	# build tensorflow .whl pkg for legacy celeron
	docker build -f Dockerfile.build-tensorflow-legacy-celeron . -t build-tensorflow-legacy-celeron --build-arg TF_IMAGE="$TF_IMAGE"
	# build ovms docker image using generated .whl file from previous build step above
	docker build -f Dockerfile.tensorflow-build-src . --build-arg PKG_NAME="$PKG_NAME" -t benchmark_client
fi
