defmodule Tensorflow.Serving.PredictRequest.InputsEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: Tensorflow.TensorProto.t() | nil
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: Tensorflow.TensorProto
end

defmodule Tensorflow.Serving.PredictRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          model_spec: Tensorflow.Serving.ModelSpec.t() | nil,
          inputs: %{String.t() => Tensorflow.TensorProto.t() | nil},
          output_filter: [String.t()]
        }
  defstruct [:model_spec, :inputs, :output_filter]

  field :model_spec, 1, type: Tensorflow.Serving.ModelSpec
  field :inputs, 2, repeated: true, type: Tensorflow.Serving.PredictRequest.InputsEntry, map: true
  field :output_filter, 3, repeated: true, type: :string
end

defmodule Tensorflow.Serving.PredictResponse.OutputsEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: Tensorflow.TensorProto.t() | nil
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: Tensorflow.TensorProto
end

defmodule Tensorflow.Serving.PredictResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          model_spec: Tensorflow.Serving.ModelSpec.t() | nil,
          outputs: %{String.t() => Tensorflow.TensorProto.t() | nil}
        }
  defstruct [:model_spec, :outputs]

  field :model_spec, 2, type: Tensorflow.Serving.ModelSpec

  field :outputs, 1,
    repeated: true,
    type: Tensorflow.Serving.PredictResponse.OutputsEntry,
    map: true
end
