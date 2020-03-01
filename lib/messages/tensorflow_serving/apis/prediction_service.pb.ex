defmodule Tensorflow.Serving.PredictionService.Service do
  @moduledoc false
  use GRPC.Service, name: "tensorflow.serving.PredictionService"

  rpc :Predict, Tensorflow.Serving.PredictRequest, Tensorflow.Serving.PredictResponse
end

defmodule Tensorflow.Serving.PredictionService.Stub do
  @moduledoc false
  use GRPC.Stub, service: Tensorflow.Serving.PredictionService.Service
end
