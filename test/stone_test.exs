defmodule StoneTest do
  use ExUnit.Case
  doctest Stone

  test "greets the world" do
    assert Stone.hello() == :world
  end
end
