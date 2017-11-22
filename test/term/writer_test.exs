defmodule Term.WriterTest do
  use ExUnit.Case, async: true
  doctest Term.Writer

  @data_provider [
    [out: "Whats up?", exp_out: "Whats up?"],
    [out: "a\nb\nc\n", exp_out: "a\nb\nc\n"]
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
