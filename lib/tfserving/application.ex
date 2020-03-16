defmodule TfServing.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: TfServing.Router, options: [port: 8000]},
      {Plug.Cowboy, scheme: :https, plug: TfServing.Router, options: plug_opts()}
    ]

    opts = [strategy: :one_for_one, name: TfServing.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp plug_opts do
    [
      port: 8443,
      cipher_suite: :strong,
      certfile: "priv/cert/cert.pem",
      keyfile: "priv/cert/privkey.pem",
      cacertfile: "priv/cert/chain.pem",
      otp_app: :tfserving
    ]
  end
end
