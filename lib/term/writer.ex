defmodule Term.Writer do
  @callback write(String.t) :: none()
  @callback before_write(String.t) :: String.t

  @moduledoc ~S"""
  Behaviour for all the terminal write operations.

  Allows to operate on the message before it gets flushed to the terminal.

  ```elixir
  defmodule My.Writer do
    use Term.Writer

    def before_write(text), do: "Yippie yay yey : #{text}"
  end

  defmodule Example do
    def example do
      My.Writer.write("Cowboy")
    end
  end

  Example.example # Outputs : "Yippie yay yey : Cowboy"
  ```

  """

  defmacro __using__(_) do
    quote do
      @behaviour Term.Writer

      def write(message, device \\ IO) do
        message |> 
          before_write |> 
          device.puts
      end

      def before_write(text), do: text

      defoverridable before_write: 1
    end
  end
end
