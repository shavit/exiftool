defmodule Exiftool.Result do
  @moduledoc """
  Information about the input file.
  """
  alias Exiftool.Result

  @type t :: %__MODULE__{
    access_date_time:                 binary | nil,
    aperture:                         binary | nil,
    bits_per_sample:                  binary | nil,
    camera_model_name:                binary | nil,
    color_components:                 binary | nil,
    color_space:                      binary | nil,
    color_tone:                       binary | nil,
    contrast:                         binary | nil,
    datetime_original:                binary | nil,
    directory:                        binary | nil,
    drive_mode:                       binary | nil,
    encoding_process:                 binary | nil,
    exiftool_version_number:          binary | nil,
    extension:                        binary | nil,
    exposure_compensation:            binary | nil,
    file_inode_change_date_time:      binary | nil,
    file_access_date_time:            binary | nil,
    file_modification_date_time:      binary | nil,
    file_name:                        binary | nil,
    file_number:                      binary | nil,
    file_permissions:                 binary | nil,
    file_size:                        binary | nil,
    file_type:                        binary | nil,
    file_type_extension:              binary | nil,
    flash:                            binary | nil,
    focal_length:                     binary | nil,
    focus_mode:                       binary | nil,
    image_height:                     binary | nil,
    image_size:                       binary | nil,
    image_width:                      binary | nil,
    iso:                              binary | nil,
    jfif_version:                     binary | nil,
    lens:                             binary | nil,
    megapixels:                       binary | nil,
    metering_mode:                    binary | nil,
    mime_type:                        binary | nil,
    owner_name:                       binary | nil,
    quality:                          binary | nil,
    resolution_unit:                  binary | nil,
    saturation:                       binary | nil,
    serial_number:                    binary | nil,
    sharpness:                        binary | nil,
    shootting_mode:                   binary | nil,
    shutter_speed:                    binary | nil,
    white_balance:                    binary | nil,
    x_resolution:                     binary | nil,
    y_cb_cr_sub_sampling:             binary | nil,
    y_resolution:                     binary | nil
  }

  defstruct [
    access_date_time:                 nil,
    aperture:                         nil,
    bits_per_sample:                  nil,
    camera_model_name:                nil,
    color_components:                 nil,
    color_space:                      nil,
    color_tone:                       nil,
    contrast:                         nil,
    datetime_original:                nil,
    directory:                        nil,
    drive_mode:                       nil,
    encoding_process:                 nil,
    exiftool_version_number:          nil,
    extension:                        nil,
    exposure_compensation:            nil,
    file_inode_change_date_time:      nil,
    file_access_date_time:            nil,
    file_modification_date_time:      nil,
    file_name:                        nil,
    file_number:                      nil,
    file_permissions:                 nil,
    file_size:                        nil,
    file_type:                        nil,
    file_type_extension:              nil,
    flash:                            nil,
    focal_length:                     nil,
    focus_mode:                       nil,
    image_height:                     nil,
    image_size:                       nil,
    image_width:                      nil,
    iso:                              nil,
    jfif_version:                     nil,
    lens:                             nil,
    megapixels:                       nil,
    metering_mode:                    nil,
    mime_type:                        nil,
    owner_name:                       nil,
    quality:                          nil,
    resolution_unit:                  nil,
    saturation:                       nil,
    serial_number:                    nil,
    sharpness:                        nil,
    shootting_mode:                   nil,
    shutter_speed:                    nil,
    white_balance:                    nil,
    x_resolution:                     nil,
    y_cb_cr_sub_sampling:             nil,
    y_resolution:                     nil
  ]

  @doc """
  Cast a map into a `%Result{}` struct

    ## Examples

        iex> Result.cast(%{bits_per_sample: "8", color_components: "3",})
        %Result{bits_per_sample: "8", color_components: "3"}
  """
  @spec cast(map) :: t
  def cast(result_map) do
    sanitized_map = sanitize_map(result_map)
    struct(%Result{}, sanitized_map)
  end

  @regex_replace_spaces ~r/([\s]+)/
  @regex_to_underscore ~r/(\s|\.|\\|\/)/

  @doc """
  Convert the map keys and prepare them for the `Result{}` struct.

    *  Replace spaces.
    *  Repalce backslashes.
    *  Replace dots.
    *  Downcase the key
  """
  @spec sanitize_map(map) :: map
  def sanitize_map(result_map) do
    result_map
    |> Enum.map(fn {k,v} -> {sanitaize_key(k), v} end)
    |> Map.new
  end

  defp sanitaize_key(key) do
    key = Regex.replace(@regex_replace_spaces, key, " ")
    key = Regex.replace(@regex_to_underscore, key, "_")
    key
    |> String.downcase
    |> String.to_atom
  end

end
