# tf-serving-elixir

Example of using Elixir gRPC client for Tensorflow Serving

## Try it

Try it [here](https://dnlserrano.dev/digits)!

## Web App

![](docs/images/intro.png)

## Elixir

To generate the Elixir files from Protobuf specs, run:

```
protoc --elixir_out=plugins=grpc:./lib/messages protos/tensorflow/core/framework/* protos/tensorflow_serving/apis/* protos/google/protobuf/* -I protos
```

## Model

To run the model for hand-written digits, run:

```
docker run -p 8501:8501 -p 8500:8500 \
  --mount type=bind,source=/path/to/mnist/digits,target=/models/digits \
  -e MODEL_NAME=digits -t tensorflow/serving &
```

