defmodule Tfserving.MixProject do
  use Mix.Project

  def project do
    [
      app: :tfserving,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:protobuf, "~> 0.7.1"},
      {:grpc, github: "elixir-grpc/grpc"},
      {:gun, github: "ninenines/gun", ref: "master", override: true},
      {:cowlib, github: "ninenines/cowlib", ref: "master", override: true},
    ]
  end
end
