defmodule Term.ExecutorTest do
  use ExUnit.Case
  doctest Term.Executor

  @commands [
    single_line: [
      command: "ls", args: [], out: "a\n", expected: "a",
    ],
    multiline: [
      command: "ls", args: ["-la"], out: "a\nb\nc\n", expected: ["a", "b", "c"],
    ]
  ]

  @stubs @commands |> Enum.each(fn 
    {name, params = [command: command, args: args, out: out, expected: expected]} -> 
      quote do
          defmodule unquote(name |> to_string |> String.capitalize ) do
          use Term.Executor
          use ExUnit.Case

          defp sanytize(text) do
            assert text == unquote(expected)
          end

          defp unquote(:execute)(cmd, params, _) do
            assert cmd == unquote(command)
            assert params == unquote(args)
            {unquote(out), 0}
          end
        end
    end
  end)

  setup do
    @stubs
  end

  test "Command with single line" do
    Single_line.exec! "ls", []
    # stub.exec!(params) 
    #assert exec!(unquote(command), unquote(args)) == unquote(expected)
  end

end