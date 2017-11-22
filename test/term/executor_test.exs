defmodule Term.ExecutorTest do
  use ExUnit.Case
  doctest Term.Executor

  @commands [
    [command: "ls", args: [], out: {"a\n", 0}, expected: "a"],
    [command: "ls", args: ["-la"], out: {"a\nb\nc\n", 0}, expected: ["a", "b", "c"]]
  ]

  use Term.Executor

  @commands |> Enum.each(fn command: command, args: args, out: out, expected: expected -> 
    test "testing command #{command} with args #{args}" do
      defmodule SysMock do
        def cmd(cmd, args, _cmd_opts \\ []) do
          send self(), [cmd, args]

          unquote(out)
        end
      end

      assert exec!(unquote(command), unquote(args), sys: SysMock) == unquote(expected)
      assert_received [unquote(command), unquote(args)]
    end
  end)
end
