defmodule TfServing.Digits do
  @moduledoc false

  def infer(image_binary) do
    uuid = UUID.uuid4()

    input_file = "in_" <> uuid
    File.write!(input_file, image_binary)

    output_file = "out_" <> uuid

    {_, 0} = System.cmd(
      "convert",
      ~w(#{input_file} -resize 28x28^ -dither FloydSteinberg -set background white
      -flatten -colors 2 -gravity center -extent 28x28 #{output_file})
    )

    {:ok, %{data: pixels_binary}} = Pixels.read_file(output_file)
    pixels = :erlang.binary_to_list(pixels_binary)

    input =
      pixels
      |> Enum.chunk_every(4)
      |> Enum.map(fn [r, g, b, _] ->
        case (r + g + b) / 3 > 128 do
          true -> 0
          _ -> 1
        end
      end)

    request =
      Tensorflow.Serving.PredictRequest.new(
        inputs: %{
          "conv2d_1_input" => Tensorflow.TensorProto.new(
            dtype: :DT_FLOAT,
            tensor_shape: Tensorflow.TensorShapeProto.new(
              dim: [
                Tensorflow.TensorShapeProto.Dim.new(size: 1),
                Tensorflow.TensorShapeProto.Dim.new(size: 28),
                Tensorflow.TensorShapeProto.Dim.new(size: 28),
                Tensorflow.TensorShapeProto.Dim.new(size: 1),
              ],
              unknown_rank: false
            ),
            float_val: input
          ),
        },
        model_spec: Tensorflow.Serving.ModelSpec.new(name: "digits")
      )

    {:ok, channel} = GRPC.Stub.connect("#{tf_serving_host()}:8500")
    {:ok, %Tensorflow.Serving.PredictResponse{outputs: outputs}} =
      Tensorflow.Serving.PredictionService.Stub.predict(channel, request)

    digit =
      outputs["dense_2"].float_val
      |> Enum.with_index()
      |> Enum.max_by(fn {val, _} -> val end)
      |> elem(1)

    File.rm(input_file)
    File.rm(output_file)

    {:ok, digit}
  end

  def tf_serving_host do
    System.get_env("TF_SERVING_HOST", "localhost")
  end
end
