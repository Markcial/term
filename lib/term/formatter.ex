defmodule Term.Formatter do
  defmacro __using__(_) do
    quote unquote: false do
      @behaviour Term.Formatter
      @styles Application.get_env(:term, :styles)
      @labels @styles |> Keyword.keys

      use Term.Writer

      @doc """
      Returns all the available styles, currently available:

      #{@styles |> inspect}
      """
      def styles, do: @styles

      @doc """
      Returns all the available labels, currently available:

      #{inspect(@labels)}
      """
      def labels, do: @labels

      @doc """
      Checks if the label exists in the configuration, being one of the following : **#{@labels |> Enum.map(&Atom.to_string/1) |> Enum.join(", ")}**
      """
      def label?(which) when which in @labels, do: true
      def label?(_), do: false

      for lbl <- @labels do
        @doc """
        Displays a message with the labelled #{lbl} format.
        
        >>> #{inspect(@styles[lbl])}
        """
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
        label |> 
          format(text) |> 
          write
      end

      def separator(char \\ "=", width \\ 80) do
        String.duplicate(char, width)
      end

      defoverridable style: 1, format: 2
    end
  end
end
