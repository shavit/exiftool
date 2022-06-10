defmodule Exiftool.MixProject do
  use Mix.Project

  def project do
    [
      app: :exiftool,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/shavit/exiftool",
      description: "Elixir library for the exiftool",
      package: [
        links: %{
          "Github" => "https://github.com/shavit/exiftool"
        },
        licenses: ["Apache 2.0"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false}
    ]
  end
end
