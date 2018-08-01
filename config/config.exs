# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :exiftool,
  path: System.get_env("EXIFTOOL_PATH")
