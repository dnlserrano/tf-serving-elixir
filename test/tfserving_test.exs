defmodule TfservingTest do
  use ExUnit.Case
  doctest Tfserving

  test "greets the world" do
    assert Tfserving.hello() == :world
  end
end
