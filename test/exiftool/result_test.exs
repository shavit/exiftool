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
    "Y Resolution" => "1"
  }

  test "should cast results into a struct" do
    assert %Result{} = Result.cast @result_map
  end

  test "should sanitize map keys" do
    assert result_map = Result.sanitize_map @result_map
    assert is_map(result_map)
  end
end
