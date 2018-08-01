defmodule ExiftoolTest do
  use ExUnit.Case
  doctest Exiftool

  test "greets the world" do
    assert Exiftool.hello() == :world
  end
end
