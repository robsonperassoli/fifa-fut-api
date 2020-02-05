defmodule FutApi.Importer do
  use GenServer
  use Timex

  alias FutApi.Importer.PlayersQueue
  alias FutApi.Fifa
  alias FutApi.Fut
  alias FutApi.Importer.Parser

  @name :importer_server

  defp fetch_players(page \\ 1, players \\ []) do
    IO.puts "Fetching players: page #{page}"
    %{
      items: items,
      total_pages: total_pages
    } = Fifa.get_players(page)

    parsed_players = items |> Enum.map(&Parser.parse_player/1)
    new_players = players ++ parsed_players

    cond do
      page === 10 -> new_players
      page < total_pages -> fetch_players(page + 1, new_players)
    end
  end

  defp schedule_fetch_players(), do: Process.send_after(self(), :fetch_players, 15_000)

  defp schedule_integration(), do: Process.send_after(self(), :integrate_player, 5_000)

  defp schedule_next_day() do
    next_execution = Timex.now
    |> Timex.shift(days: 1)
    |> Timex.set(hour: 2, minute: 0, second: 0)

    millis_until_next_execution = Timex.diff(next_execution, Timex.now, :milliseconds)
    IO.puts "Scheduled next execution for #{next_execution}"

    Process.send_after(self(), :fetch_players, millis_until_next_execution)
  end

  defp integrate_next(), do: Process.send(self(), :integrate_player, [])

  defp integrate_player({:empty, new_state}) do
    schedule_next_day()

    new_state
  end

  defp integrate_player({{:value, player}, new_state}) do
    Fut.integrate_player(player)
    integrate_next()

    new_state
  end

  # Client
  def start_link(_args) do
    GenServer.start_link(__MODULE__, nil, name: @name)
  end

  # Server
  @spec init(any) :: {:ok, :queue.queue(any)}
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
    new_state = integrate_player(:queue.out(state))

    {:noreply, new_state}
  end

  def terminate(_reason, state) do
    PlayersQueue.set(state)
  end
end
