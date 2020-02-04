defmodule FutApi.Importer do
  use GenServer

  alias FutApi.Importer.PlayersQueue
  alias FutApi.Fifa
  alias FutApi.Repo
  alias FutApi.Fut

  @name :importer_server

  defp fetch_players(page \\ 1, players \\ []) do
    IO.puts "Fetching players: page #{page}"
    {:ok, response} = Fifa.get_players(page)
    %{body: body} = response
    %{"items" => items, "page" => page, "totalPages" => totalPages} = body

    new_players = players ++ items

    cond do
      page === totalPages -> new_players
      page < totalPages -> fetch_players(page + 1, new_players)
    end
  end

  defp save(params) do
    %{"name" => name, "rating" => rating} = params

    %{name: name, rating: rating}
    |> Fut.create_player()
  end

  defp schedule_fetch_players() do
    Process.send_after(self(), :fetch_players, 15_000)
  end

  defp schedule_integration() do
    Process.send_after(self(), :integrate_player, 5_000)
  end

  # Client
  def start_link(_args) do
    GenServer.start_link(__MODULE__, nil, name: @name)
  end

  # Server
  def init(_state) do
    state = PlayersQueue.get()

    if :queue.is_empty(state) do
      schedule_fetch_players()
    end

    {:ok, state}
  end

  def handle_info(:fetch_players, _state) do
    IO.puts "Starting to fetch players"

    state = fetch_players()
    |> :queue.from_list()

    schedule_integration()

    {:noreply, state}
  end

  def handle_info(:integrate_player, state) do
    {out, new_state} = :queue.out(state)

    unless out == :empty do
      {:value, player} = out
      save(player)
      Process.send(self(), :integrate_player, [])
    end

    {:noreply, new_state}
  end

  def terminate(_reason, state) do
    PlayersQueue.set(state)
  end
end
