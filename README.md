# Exiftool

[![Build Status](https://travis-ci.org/shavit/exiftool.svg?branch=master)](https://travis-ci.org/shavit/exiftool)

Elixir library for the [exiftool](https://www.sno.phy.queensu.ca/~phil/exiftool)

Usage
```
iex> Exiftool.execute([file_path])
{:ok, result}
```

## Installation

If [available in Hex](https://hexdocs.pm/exiftool), the package can be installed
by adding `exiftool` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:exiftool, "~> 0.2.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm/exiftool). Once published, the docs can
be found at [https://hexdocs.pm/exiftool](https://hexdocs.pm/exiftool).
