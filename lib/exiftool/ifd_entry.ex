defmodule Exiftool.IfdEntry do
  @moduledoc """
  `Exiftool.IfdEntry`
  """
  defstruct [:tag, :tag_name, :type, :type_name, :value_count, :value]

  @field_types %{
    # 8-bit unsigned integer
    1 => :byte,
    # 8-bit with 7-bit ascii and 1-bit NUL
    2 => :ascii,
    # 16-bite unsiged integer
    3 => :short,
    # 32-bit unsigned integer
    4 => :long,
    # 8-byte of two long
    5 => :rational,
    # 8-bit signed integer
    6 => :sbyte,
    # 8-bit that may contain anhything
    7 => :undefined,
    # 16-bit signed integer
    8 => :sshort,
    # 32-bit signed integer
    9 => :slong,
    # 8-byte, two slong, numerator and denominator
    10 => :srational,
    # 4-byte single precision
    11 => :float,
    # 8-byte double precision
    12 => :double
  }

  @field_tags %{
    254 => :new_subfile_type,
    255 => :subfile_type,
    256 => :image_width,
    257 => :image_length,
    258 => :bits_per_sample,
    259 => :compression,
    262 => :photometric_interpretation,
    263 => :threshholding,
    264 => :cell_width,
    265 => :cell_length,
    266 => :fill_order,
    269 => :document_name,
    270 => :image_description,
    271 => :make,
    272 => :model,
    273 => :strip_offsets,
    274 => :orientation,
    277 => :samples_per_pixel,
    278 => :rows_per_strip,
    279 => :strip_byte_count,
    280 => :min_sample_value,
    281 => :max_sample_value,
    282 => :x_resolution,
    283 => :y_resolution,
    284 => :planar_configuration,
    285 => :page_name,
    286 => :x_position,
    287 => :y_position,
    288 => :free_offsets,
    289 => :free_byte_counts,
    290 => :gray_responsive_unit,
    291 => :gray_responsive_unit,
    292 => :t4_options,
    293 => :t6_options,
    296 => :resolution_unit,
    297 => :page_number,
    301 => :transfer_function,
    305 => :software,
    306 => :date_time,
    315 => :artist,
    316 => :host_computer,
    317 => :predictor,
    318 => :white_point,
    319 => :primary_chromaticities,
    320 => :color_map,
    321 => :halftone_hints,
    322 => :tile_width,
    323 => :tile_length,
    324 => :tile_offsets,
    325 => :tile_byte_counts,
    332 => :ink_set,
    333 => :ink_names,
    334 => :number_of_inks,
    336 => :dot_range,
    337 => :target_printer,
    338 => :extra_samples,
    339 => :sample_format,
    340 => :s_min_sample_value,
    341 => :s_max_sample_value,
    342 => :transfer_range,
    512 => :jpeg_proc,
    513 => :jpeg_interchange_format,
    514 => :jpeg_interchange_format_length,
    515 => :jpeg_restart_interval,
    517 => :jpeg_lossless_predictors,
    518 => :jpeg_point_transforms,
    519 => :jpeg_q_tables,
    520 => :jpeg_dc_tables,
    521 => :jpeg_ac_tables,
    529 => :ycbcr_coefficients,
    530 => :ycbcr_sub_sampling,
    531 => :ycbcr_positioning,
    532 => :reference_black_white,
    700 => :xmp,
    32781 => :image_id,
    32932 => :wang_annotation,
    33432 => :copyright,
    33445 => :md_file_tag,
    33446 => :md_scale_pixel,
    33447 => :md_color_table,
    33448 => :md_lab_name,
    33449 => :md_sample_info,
    33450 => :md_prep_date,
    33451 => :md_prep_time,
    33452 => :md_file_units,
    33723 => :iptc,
    33918 => :ingr_packet_data_tag,
    33919 => :ingr_flag_registers,
    34377 => :photoshop,
    34675 => :icc_profile,
    34908 => :hylafax_fax_recv_params,
    34909 => :hylafax_fax_sub_address,
    34910 => :hylafax_fax_recv_time,
    34732 => :image_layer,
    37724 => :image_source_data,
    42112 => :gdal_metadata,
    42113 => :gdal_nodata,
    50215 => :oce_scanjob_description,
    50216 => :oce_application_selector,
    50217 => :oce_identification_number,
    50218 => :oce_image_logic_characteriestics,
    50341 => :epson_print_image_matching,
    50784 => :alias_layer_metadata
  }

  @doc """
  Each entry has:
  - 2-byte tag
  - 2-byte type
  - 4-byte type value count
  - 4-byte value offset
  """
  def new(
        data,
        <<tag::little-size(16), type::little-size(16), value_count::little-size(32),
          value_offset::little-size(32), rest::binary>> = entries
      )
      when is_binary(entries) do
    tag_name = @field_tags[tag]
    type_name = @field_types[type]
    value = get_field_value(data, type, value_offset)

    %__MODULE__{
      tag: tag,
      tag_name: tag_name,
      type: type,
      type_name: type_name,
      value_count: value_count,
      value: value
    }
  end

  def new(_invalid), do: nil

  defp get_field_value(data, 5, offset), do: get_field_value_offset(data, offset)
  defp get_field_value(data, 10, offset), do: get_field_value_offset(data, offset)
  defp get_field_value(data, 12, offset), do: get_field_value_offset(data, offset)
  defp get_field_value(_data, _type, value_offset), do: value_offset

  defp get_field_value_offset(data, offset) do
    with <<num::little-size(32), denum::little-size(32), _::binary>> <-
           :binary.part(data, offset, 8 * 8) do
      num / denum
    end
  end
end
