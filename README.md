# OpenVINO Model Server for Legacy Intel Celeron

OpenVINO Model Server benchmark_client application requires TensorFlow. However, pre-built TensorFlow-cpu binaries require AVX HW support thus crashing on legacy Intel Celeron HW. This repo will build TensorFlow-cpu without AVX


## Cross Compile Build (Fast Method)

Building TensorFlow requires lots of CPU time. Building on an Intel Xeon and after deploying on an Intel Celeron platform will tremendously reduce the build time.

<b>Xeon Steps</b>

Default build will use: TF_IMAGE="tensorflow/build:2.13-python3.9"

```
./build-client.sh build_tensorflow_only
```

To specify a different Python and Tensorflow version:

```
TF_IMAGE="tensorflow/build:2.13-python3.10" ./build-client.sh build_tensorflow_only
```

After the build completes copy the generated tensorflow-*.whl to the target Intel Celeron system

-rw-r--r-- 1 who who 214453809 Sep 20 18:59 tensorflow-2.13.1-cp310-cp310-linux_x86_64.whl

<b>Celeron Steps</b>

Ensure the tensorflow-2.13.1-cp39-cp39-linux_x86_64.whl is in the current directory. Running the below step will build the OVMS benchmark_client application and utilize the .whl file.

```
./build-client.sh from_binary
```

## Single System Compile and Install (Slow Method)

<b>Celeron Steps</b>

Building TensorFlow requires lots of CPU time and memory. Refer to https://www.tensorflow.org/install/source to limit memory via --local_ram_resources=2048. This will require a change in the Dockerfile.build-tensorflow-legacy-celeron file to add this limitation.

```
./build-client.sh
```
