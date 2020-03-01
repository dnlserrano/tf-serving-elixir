# tf-serving-elixir

Elixir gRPC client for Tensorflow Serving

## Use

To generate the Elixir files from Protobuf specs, just run:

```
protoc --elixir_out=plugins=grpc:./lib/messages protos/tensorflow/core/framework/* protos/tensorflow_serving/apis/* protos/google/protobuf/* -I protos
```
