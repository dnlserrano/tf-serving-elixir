defmodule TfServing.Router do
  @moduledoc """
  Documentation for Tfserving.
  """
  use Plug.Router

  plug :match
  plug :dispatch

  @jquery "jquery-3.4.1.js"
  @decoded_marker "image=data:image/png;base64,"
  @max_length 1_000_000

  get "/" do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, File.read!("web/index.html"))
  end

  get "/#{@jquery}" do
    conn
    |> put_resp_content_type("text/javascript")
    |> send_resp(200, File.read!("web/#{@jquery}"))
  end

  post "/guess" do
    {:ok, body, conn} =
      Plug.Conn.read_body(conn, length: @max_length)

    @decoded_marker <> base64_encoded_image = URI.decode_www_form(body)
    {:ok, image_binary} = Base.decode64(base64_encoded_image)

    {:ok, digit} = TfServing.Digits.infer(image_binary)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, "{\"digit\": #{digit}}")
  end
end
