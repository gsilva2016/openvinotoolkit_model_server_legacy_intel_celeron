# OpenVINO Model Server for Legacy Intel Celeron

OpenVINO Model Server benchmark_client application requires TensorFlow. However, pre-built TensorFlow-cpu binaries require AVX HW support thus crashing on legacy Intel Celeron HW. This repo will build TensorFlow-cpu without AVX


## Cross Compile Build (Fast Method)

Building TensorFlow requires lots of CPU time. Building on an Intel Xeon will tremendously reduce the build time.

<b>Xeon Steps</b>

```
./build-client.sh build_tensorflow_only
```

After the build completes copy the generated /wheels/tensorflow/tensorflow-2.13.1-cp39-cp39-linux_x86_64.whl from the Docker image build-tensorflow-legacy-celeron to the target Intel Celeron system

```
docker run -v `pwd`:/savedir build-tensorflow-legacy-celeron /usr/bin/cp /wheels/tensorflow/tensorflow-2.13.1-cp39-cp39-linux_x86_64.whl /savedir
ls -l *.whl
```

-rw-r--r-- 1 root root 214453809 Sep 20 18:59 tensorflow-2.13.1-cp39-cp39-linux_x86_64.whl


<b>Celeron Steps</b>

Ensure the tensorflow-2.13.1-cp39-cp39-linux_x86_64.whl is in the current directory.

```
./build-client.sh from_binary
```

## Single System Compile (Slow Method)

<b>Celeron Steps</b>

Building TensorFlow requires lots of CPU time and memory. Refer to https://www.tensorflow.org/install/source to limit memory via --local_ram_resources=2048. This will require a change in the Dockerfile.build-tensorflow-legacy-celeron file to add this limitation.

```
./build-client.sh
```
