defmodule Term.Mixfile do
  use Mix.Project

  def project do
    [
      app: :term,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Term",
      source_url: "https://github.com/markcial/term",
      homepage_url: "http://github.com/markcial/term",
      test_coverage: [tool: Coverex.Task, log: :debug],
      # The main page in the docs
      docs: [
        main: "Term",
        # logo: "path/to/logo.png",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Term.App, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:coverex, "~> 1.4.10", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev, :test], runtime: false},
      {:inch_ex, "~> 0.5.6", only: [:dev, :test], runtime: false},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.16", only: [:dev, :test], runtime: false}
    ]
  end
end
