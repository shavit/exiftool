defmodule Exiftool do
  @moduledoc """
  Documentation for Exiftool.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Exiftool.hello()
      :world

  """
  def hello do
    IO.inspect ffmpeg_path()
    :world
  end

  @doc """

  """
  def execute(args) do
    case System.cmd ffmpeg_path(), args, stderr_to_stdout: true do
      {data, 0} -> {:ok, parse_result(data)}
      error -> {:error, error}
    end
  end

  defp parse_result(raw_output) do
    String.split(raw_output, "\n")
      |> Enum.filter(&(&1 != ""))
      |> Enum.map(fn x ->
        String.split(x, ":")
        |> Enum.map(&String.trim/1)
        |> List.to_tuple
      end)
  end

  defp ffmpeg_path do
    case Application.get_env(:exiftool, :path, nil) do
      nil -> System.find_executable("exiftool") || exit("Executable not found")
      path -> path
    end
  end
end
