defmodule Term.ReaderTest do
  
  use ExUnit.Case, async: true
  doctest Term.Reader

  @data_provider [
    [out: "Whats up?", exp_out: "Whats up?", input: "not much, wbu?\n", exp_input: "not much, wbu?"]
  ]

  use Term.Reader

  @data_provider |> Enum.each(fn 
    params = [out: out, exp_out: exp_out, input: input, exp_input: exp_input] -> 
      
      test "test with data : #{inspect params}" do
        defmodule SysMock do
          def gets(text) do
            send self(), text
  
            unquote(input)
          end
        end
        assert read(unquote(out), SysMock) == unquote(exp_input)
        assert_received unquote(exp_out)
      end
  end)
end
  