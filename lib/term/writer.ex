defmodule Term.Writer do
  @callback write(String.t) :: nil
  defmacro __using__(_) do
    quote do
      @behaviour Term.Writer

      def write(message, device \\ IO) do
        message |> before_write |> device.puts
      end

      defp before_write(text), do: text

      defoverridable before_write: 1
    end
  end
end
