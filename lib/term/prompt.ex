defmodule Term.Prompt do

  defmacro __using__(_) do
    quote do
      @behaviour Term.Prompt

      use Term.Reader

      def prompt(message) do
        message |> 
          read |> 
          prompted
      end

      defp prompted(result), do: result

      def valid?(selected, options) do
      end

      def choose(subject, options) do
        subject = question(subject)
        options = choices(options)

        answer = prompt(subject)

        IO.inspect(answer)
      end

      def choices(options), do: options

      defp question(text), do: text

      defoverridable prompted: 1, choices: 1, valid?: 2, question: 1
    end
  end
end
