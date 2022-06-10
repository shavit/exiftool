defmodule Exiftool.Result do
  @moduledoc """
  Normalize exif data.
  """

  @doc """
  read/1 normalize map keys.

    *  Replace spaces.
    *  Replace backslashes.
    *  Replace dots.
    *  Downcase keys.

    ## Examples

        iex> Result.read(%{bits_per_sample: "8", color_components: "3",})
        %{"bits_per_sample" => "8", "color_components" => "3"}
  """
  @spec read(map) :: Map.t()
  def read(result_map) do
    result_map
    |> Enum.map(fn {k, v} -> {sanitaize_key(k), v} end)
    |> Map.new()
  end

  @regex_replace_spaces ~r/([\s]+)/
  @regex_to_underscore ~r/(\s|\.|\\|\/)/

  defp sanitaize_key(key) do
    key = Regex.replace(@regex_replace_spaces, key, " ")
    key = Regex.replace(@regex_to_underscore, key, "_")
    String.downcase(key)
  end
end
