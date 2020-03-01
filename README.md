# tf-serving-elixir

Elixir bindings for gRPC Tensorflow Serving APIs

## Use

To generate the Elixir files from Protobuf specs, just run:

```
protoc --elixir_out=./lib/messages protos/tensorflow/core/framework/* protos/tensorflow_serving/apis/* protos/google/protobuf/* -I protos
```
