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
  def read(m) when is_map(m) do
    m |> Enum.map(&map_sanitize_kv/1) |> Map.new()
  end

  defp map_sanitize_kv({k, v}), do: {sanitize_key(k), sanitize_value(v)}

  @regex_replace_spaces ~r/([\s]+)/
  @regex_to_underscore ~r/(\s|\.|\\|\/)/

  defp sanitize_key(key) do
    key = Regex.replace(@regex_replace_spaces, key, " ")
    key = Regex.replace(@regex_to_underscore, key, "_")
    String.downcase(key)
  end

  defp sanitize_value(value) do
    case String.trim(value) do
      "" -> nil
      v -> v
    end
  end
end
