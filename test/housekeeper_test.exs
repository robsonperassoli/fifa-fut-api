defmodule HousekeeperTest do
  use ExUnit.Case
  doctest Housekeeper

  test "greets the world" do
    assert Housekeeper.hello() == :world
  end
end
