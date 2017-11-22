defmodule Term.Profiler do
  defmodule Monitor do
    use GenServer

    def start_link do
      GenServer.start_link __MODULE__, %{}, name: __MODULE__
    end

    def init(state) do
      {:ok, pid} = :os_mon.start(:cpu_sup, true)
      state = %{:cpu => pid}
      {:ok, state}
    end
  end
  defmacro __using__(_) do
    quote do
      @behaviour Term.Profiler

      use GenServer

      def cpus() do
        :cpu_sup.start
        details = :cpu_sup.util([:per_cpu])
        :cpu_sup.stop 

        details
      end
    end
  end
end
