defmodule Term.Formatter do
  defmacro __using__(_) do
    quote unquote: false do
      @behaviour Term.Formatter
      @styles Application.get_env(:term, :styles)
      @labels @styles |> Keyword.keys

      def styles, do: @styles
      def labels, do: @labels
      def label?(which), do: which in labels()

      for lbl <- @labels do
        def unquote(lbl)(message) do
          log(unquote(lbl), message)
        end
      end

      def style(tag) do
        case label?(tag) do
          true ->
            {
              :ok,
              styles()
              |> Keyword.get(tag)
              |> Enum.map(&code/1)
              |> Enum.join()
            }

          false ->
            {:err, "Not available"}
        end
      end

      defp reset, do: code(:reset)
      defp code(label), do: apply(IO.ANSI, label, [])

      defp format(label, text) do
        case style(label) do
          {:ok, codes} -> codes <> text <> reset()
          {:err, _} -> text
        end
      end

      def log(label, text) do
        format(label, text) |> write
      end

      def separator(char \\ "=", width \\ 80) do
        String.duplicate(char, width)
      end

      defp write(text), do: IO.puts(text)

      defoverridable style: 1, format: 2
    end
  end
end
