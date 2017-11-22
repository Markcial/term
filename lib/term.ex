defmodule Term do
  @moduledoc """
  Documentation for Term.
  """
  use Term.Formatter
  use Term.Profiler
  use Term.Prompt
  use Term.Reader
  use Term.Executor

  def before_write(text), do: "WTF?! #{text}"

end
