{:ok, channel} = GRPC.Stub.connect("localhost:8500")

request =
  Tensorflow.Serving.PredictRequest.new(
    inputs: %{
      "x" => Tensorflow.TensorProto.new(
        dtype: :DT_FLOAT,
        tensor_shape: Tensorflow.TensorShapeProto.new(
          dim: [Tensorflow.TensorShapeProto.Dim.new(size: 2)],
          unknown_rank: false
        ),
        float_val: [55.0, 33.0]
      ),
    },
    model_spec: Tensorflow.Serving.ModelSpec.new(
      name: "half_plus_two",
    )
  )

{:ok, reply} = channel |> Tensorflow.Serving.PredictionService.Stub.predict(request)

# {:ok,
#  %Tensorflow.Serving.PredictResponse{
#    model_spec: %Tensorflow.Serving.ModelSpec{
#      name: "half_plus_two",
#      signature_name: "serving_default",
#      version_choice: {:version, %Google.Protobuf.Int64Value{value: 123}}
#    },
#    outputs: %{
#      "y" => %Tensorflow.TensorProto{
#        bool_val: [],
#        dcomplex_val: [],
#        double_val: [],
#        dtype: :DT_FLOAT,
#        float_val: [29.5, 18.5],
#        half_val: [],
#        int64_val: [],
#        int_val: [],
#        resource_handle_val: [],
#        scomplex_val: [],
#        string_val: [],
#        tensor_content: "",
#        tensor_shape: %Tensorflow.TensorShapeProto{
#          dim: [%Tensorflow.TensorShapeProto.Dim{name: "", size: 2}],
#          unknown_rank: false
#        },
#        uint32_val: [],
#        uint64_val: [],
#        variant_val: [],
#        version_number: 0
#      }
#    }
#  }}
