# Exiftool

Elixir library for the [exiftool](https://www.sno.phy.queensu.ca/~phil/exiftool)

Usage
```
iex> Exiftool.execute(file_path)
{:ok, %Exiftool.Result{}}
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `exiftool` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:exiftool, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/exiftool](https://hexdocs.pm/exiftool).
