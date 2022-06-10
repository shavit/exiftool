defmodule Exiftool.ResultTest do
  use ExUnit.Case
  doctest Exiftool

  alias Exiftool.Result

  @result_map %{
    "Bits Per Sample" => "8",
    "Color Components" => "3",
    "Directory" => "test/fixtures",
    "Encoding Process" => "Baseline DCT, Huffman coding",
    "ExifTool Version Number" => "11.01",
    "File Access Date/Time" => "2018:08:02 22:40:07-04:00",
    "File Inode Change Date/Time" => "2018:08:02 20:50:24-04:00",
    "File Modification Date/Time" => "2018:08:02 20:50:24-04:00",
    "File Name" => "image-1.jpeg",
    "File Permissions" => "rw-r--r--",
    "File Size" => "11 kB",
    "File Type" => "JPEG",
    "File Type Extension" => "jpg",
    "Image Height" => "183",
    "Image Size" => "275x183",
    "Image Width" => "275",
    "JFIF Version" => "1.01",
    "MIME Type" => "image/jpeg",
    "Megapixels" => "0.050",
    "Resolution Unit" => "None",
    "X Resolution" => "1",
    "Y Cb Cr Sub Sampling" => "YCbCr4:2:0 ",
    "Y Resolution" => "1",
    "APP14 Flags 0" => "[14], Encoded with Blend=1 downsampling",
    "APP14 Flags 1" => "(none)",
    "Baby Age" => " (not set)",
    "Data Dump" => " (Binary data 8200 bytes, use -b option to extract)",
    "Internal Serial Number" => " (F23) 2008:11:20 no. 0182",
    "Manufacture Date" => " ",
    "Scale Factor To 35 mm Equivalent" => "5.8",
    "Sensor" => " ",
    "Thumbnail Image" => " (Binary data 7496 bytes, use -b option to extract)"
  }

  test "should cast results into a map" do
    assert m = Result.read(@result_map)
    assert is_map(m)
    assert m["app14_flags_0"] == "[14], Encoded with Blend=1 downsampling"
    assert m["app14_flags_1"] == "(none)"
    assert m["baby_age"] == "(not set)"
    assert m["bits_per_sample"] == "8"
    assert m["internal_serial_number"] == "(F23) 2008:11:20 no. 0182"
    assert m["manufacture_date"] == nil
    assert m["sensor"] == nil
    assert m["scale_factor_to_35_mm_equivalent"] == "5.8"
    assert m["thumbnail_image"] == "(Binary data 7496 bytes, use -b option to extract)"
    assert m["y_cb_cr_sub_sampling"] == "YCbCr4:2:0"
  end
end
