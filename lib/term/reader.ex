defmodule Term.Reader do
  @callback read(String.t) :: String.t

  defmacro __using__(_) do
    quote do
      @behaviour Term.Reader

      def read(text, device \\ IO) do
        text |> 
          device.gets |> 
          after_read
      end

      def before_read(text), do: text

      @spec after_read(String.t) :: String.t
      defp after_read(input), do: input |> String.trim

      defoverridable after_read: 1, before_read: 1, read: 2
    end
  end
end
