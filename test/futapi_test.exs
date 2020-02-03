defmodule FutApiTest do
  use ExUnit.Case
  doctest FutApi

  test "greets the world" do
    assert FutApi.hello() == :world
  end
end
