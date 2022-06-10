defmodule Exiftool do
  @moduledoc """
  `Exiftool` reads exif data from files into a map.
  """
  alias Exiftool.Result

  @doc """
  Run the exiftool

  ## Examples

      iex> {:ok, result} = Exiftool.execute(["test/fixtures/image-1.jpeg"])
      iex> result["file_type_extension"]
      "jpg"
      iex> result["jfif_version"]
      "1.01"
  """
  def execute(args) when is_list(args) do
    case System.cmd(exiftool_path(), args, stderr_to_stdout: true) do
      {data, 0} -> {:ok, parse_result(data)}
      error -> {:error, error}
    end
  end

  @regex_result_line ~r/([A-Za-z0-9-\:\/\.,\s]+[a-zA-Z0-9])[\s]+:\s([A-Za-z0-9-\:\/\.,\s\[\]\(\)]+)/

  @doc """
  parse_result/1 transforms exiftool output into exif data map.
  """
  @spec parse_result(binary) :: Result.t()
  def parse_result(raw_output) do
    raw_output
    |> String.split("\n")
    |> Enum.map(&map_result_line/1)
    |> Enum.filter(&(!is_nil(&1)))
    |> Enum.reduce(%{}, fn {k, v}, acc -> Map.put(acc, k, v) end)
    |> Result.read()
  end

  defp map_result_line(x) when is_binary(x) do
    case Regex.run(@regex_result_line, x, [:binary]) do
      [_line, key, value] -> {key, value}
      _reg_no_match -> nil
    end
  end

  defp exiftool_path do
    cmd = Application.get_env(:exiftool, :path) || "exiftool"
    System.find_executable(cmd) || exit("Executable not found")
  end
end
