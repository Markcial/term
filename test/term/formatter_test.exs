defmodule Term.FormatterTest do
  use ExUnit.Case, async: true
  doctest Term.Formatter

  @data_provider [
  ]

  use Term.Writer
  
  @data_provider |> Enum.each(fn 
    params = [out: out, exp_out: exp_out] -> 
      
      test "test with data : #{inspect params}" do
        defmodule SysMock do
          def puts(text), do: text
        end
        assert write(unquote(out), SysMock) == unquote(exp_out)
      end
  end)
end
