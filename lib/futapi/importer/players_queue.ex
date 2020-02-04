defmodule FutApi.Importer.PlayersQueue do
  use GenServer

  @name :players_queue_server

  # Client
  def start_link(_args) do
    GenServer.start_link(__MODULE__, :queue.new(), name: @name)
  end

  def set(players) do
    GenServer.cast(@name, {:set, players})
  end

  def get() do
    GenServer.call(@name, :get)
  end

  # Server
  def init(state) do
    {:ok, state}
  end

  def handle_cast({:set, players}, _state) do
    new_state = :queue.from_list(players)

    {:noreply, new_state}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end
end
