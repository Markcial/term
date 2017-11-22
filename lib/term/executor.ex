defmodule Term.Executor do

  @type stdout :: String.t | [String.t]

  @callback exec!(String.t(), []) :: stdout 
  @callback exec(String.t(), []) :: {:err, any()} | {:ok, stdout}

  @callback sanytize(stdout) :: stdout

  defmacro __using__(_) do
    quote do
      @behaviour Term.Executor

      @doc """
      Checks if a program exists.
      """
      def has?(prog, opts \\ []) do
        sys = Keyword.get(opts, :sys, System)
        case sys.cmd("which", [prog]) do
          {_, 0} -> true
          _ -> false
        end
      end

      def exec!(cmd, args \\ [], opts \\ []) do
        case exec(cmd, args, opts) do
          {:ok, out} -> out
          {:err, out: out, code: code} -> raise "Error(#{code}): #{out}."
        end
      end

      def exec(cmd, args \\ [], opts \\ []) do
        cmd_opts = Keyword.get(opts, :opts, [])
        sys = Keyword.get(opts, :sys, System)
        case sys.cmd(cmd, args, cmd_opts) do
          {out, 0} -> {:ok, sanytize(out)}
          {out, code} -> {:err, out: out, code: code}
        end
      end

      defp sanytize([line]) when is_binary(line), do: line
      defp sanytize(line) when is_binary(line) do
        line |> 
          String.trim |> 
          String.split("\n") |> 
          sanytize
      end
      defp sanytize(lines), do: lines

      defoverridable sanytize: 1
    end
  end
end
