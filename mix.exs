defmodule Phonebook.MixProject do
  use Mix.Project

  def project do
    [
      app: :phonebook,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Phonebook.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.5.7"},
      {:phoenix_pubsub, "~> 2.0.0"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:absinthe, "~> 1.5.4"},
      {:absinthe_plug, "~> 1.5.1"},
      {:absinthe_phoenix, "~> 2.0"},
      {:dataloader, "~>1.0"},
      {:ecto_shorts, "~>0.1.7"},
      {:ecto_sql, "~> 3.5.3"},
      {:postgrex, "~> 0.15"},
      {:faker, "~> 0.13", only: :test}
    ]
  end
end
