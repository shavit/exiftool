defmodule Exiftool.Result do
  @moduledoc """
  Information about the input file.
  """
  alias Exiftool.Result

  @type t :: %__MODULE__{
    exiftool_version_number:             binary
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
  Cast the result list into a %Result{}

  ## Examples

      iex> Result.cast([{"ExifTool Version Number", "11.01"}])
      %Result{exiftool_version: "11.01"}
  """
  def cast(result) when is_list(result) do
    %Result{
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
    }
  end


  @doc """
  Cast a map into a `%Result{}` struct

    ## Examples

        iex> Result.cast(%{bits_per_sample: "8", color_components: "3",})
        %Result{bits_per_sample: "8", color_components: "3"}
  """
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
