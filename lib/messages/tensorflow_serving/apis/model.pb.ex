defmodule Tensorflow.Serving.ModelSpec do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          version_choice: {atom, any},
          name: String.t(),
          signature_name: String.t()
        }
  defstruct [:version_choice, :name, :signature_name]

  oneof :version_choice, 0
  field :name, 1, type: :string
  field :version, 2, type: Google.Protobuf.Int64Value, oneof: 0
  field :version_label, 4, type: :string, oneof: 0
  field :signature_name, 3, type: :string
end
