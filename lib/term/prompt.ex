defmodule Term.Prompt do
  @callback prompt(String.t) :: String.t
  @callback prompted(String.t) :: String.t
  

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
      end

      def choices(options), do: options

      defp question(text), do: text

      defoverridable prompted: 1, choices: 1, valid?: 2, question: 1
    end
  end
end
