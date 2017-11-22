defmodule Term.Reader do
  @callback read(String.t) :: String.t
  @callback before_read(String.t) :: String.t
  @callback after_read(String.t) :: String.t

  @moduledoc ~S"""
  Writer behaviour for interactive operations.

  Its callbacks allows you to plug to the sent or received data. This way you can sanitize or check user input
  or decorate, format or check data before writing it to the terminal.

  ```elixir
  defmodule My.Reader do
    use Term.Reader

    def before_read(text), do: "System wants to know if you want to #{text}"
    def after_read(text), do: "@@** #{String.trim(text)} **@@"
  end

  defmodule Example do
    def example do
      My.Reader.read("reboot the computer")
    end
  end

  Example.example # (Requests for user interaction) : "System wants to know if you want to reboot the computer"
  yes⏎
  # Outputs : "@@** yes **@@"
  ```
  """

  defmacro __using__(_) do
    quote do
      @behaviour Term.Reader

      def read(text, device \\ IO) do
        text |> 
          before_read |>
          device.gets |> 
          after_read
      end

      def before_read(text), do: text

      def after_read(input), do: input |> String.trim

      defoverridable after_read: 1, before_read: 1, read: 2
    end
  end
end
