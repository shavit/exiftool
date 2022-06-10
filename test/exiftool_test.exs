defmodule ExiftoolTest do
  use ExUnit.Case
  doctest Exiftool

  @image_path "test/fixtures/image-1.jpeg"

  test "should return the executable path from environment variable with a fallback to the system path" do
    assert {:ok, m} = Exiftool.execute([@image_path])
    assert is_map(m)

    # assert_raise RuntimeError, fn ->
    # :ok = Application.put_env(:exiftool, :path, "/dev/null")
    # Exiftool.execute([@image_path])
    # :ok = Application.delete_env(:exiftool, :path)
    # end
  end

  test "should read keys and values with different formats" do
    assert {:ok, m} = Exiftool.execute([@image_path])
    assert m["bits_per_sample"] == "8"
    assert m["image_size"] == "275x183"
    assert m["y_cb_cr_sub_sampling"] == "YCbCr4:2:0 (2 2)"
  end

  @raw_result_data "ExifTool Version Number         : 11.01\nFile Name                       : image-1.jpeg\nDirectory                       : test/fixtures\nFile Size                       : 11 kB\nFile Modification Date/Time     : 2018:08:02 20:50:24-04:00\nFile Access Date/Time           : 2018:08:02 22:40:07-04:00\nFile Inode Change Date/Time     : 2018:08:02 20:50:24-04:00\nFile Permissions                : rw-r--r--\nFile Type                       : JPEG\nFile Type Extension             : jpg\nMIME Type                       : image/jpeg\nJFIF Version                    : 1.01\nResolution Unit                 : None\nX Resolution                    : 1\nY Resolution                    : 1\nImage Width                     : 275\nImage Height                    : 183\nEncoding Process                : Baseline DCT, Huffman coding\nBits Per Sample                 : 8\nColor Components                : 3\nY Cb Cr Sub Sampling            : YCbCr4:2:0 (2 2)\nImage Size                      : 275x183\nMegapixels                      : 0.050\n"

  test "should parse the output" do
    assert %{} = Exiftool.parse_result(@raw_result_data)
  end
end
