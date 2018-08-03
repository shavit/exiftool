defmodule Exiftool do
  @moduledoc """
  Documentation for Exiftool.
  """

  @doc """
  Run the exiftool

  ## Examples

      iex> Exiftool.execute(["test/fixtures/image-1.jpeg"])
      {:ok, %Exiftool.Result{}}

  """
  def execute(args) when is_list(args) do
    case System.cmd ffmpeg_path(), args, stderr_to_stdout: true do
      {data, 0} -> {:ok, parse_result(data)}
      error -> {:error, error}
    end
  end

  alias Exiftool.Result

  @regex_result_line ~r/([A-Za-z0-9-\:\/\.,\s]+[a-zA-Z0-9])[\s]+:\s([A-Za-z0-9-\:\/\.,\s]+)/

  @spec parse_result(binary) :: Result.t
  def parse_result(raw_output) do
    String.split(raw_output, "\n")
      |> Enum.filter(&(&1 != ""))
      |> Enum.map(fn x ->
        [_line, key, value] = Regex.run(@regex_result_line, x, [:binary])
        {key, value}
      end)
      |> Map.new
      |> Result.cast
  end

  defp ffmpeg_path do
    case Application.get_env(:exiftool, :path, nil) do
      nil -> System.find_executable("exiftool") || exit("Executable not found")
      path -> path
    end
  end
end
