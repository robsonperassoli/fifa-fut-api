defmodule FutApi.Fut do
  import Ecto.Query, warn: false
  alias FutApi.Repo
  alias FutApi.Fut.{Player, Nation, Club, League}

  def data(), do: Dataloader.Ecto.new(Repo, query: &query/2)

  def query(queryable, _params), do: queryable

  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  def update_player(%Player{} = player, %{} = attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  def get_player!(id), do: Repo.get!(Player, id)
  def get_player(id), do: Repo.get(Player, id)

  def list_players(%{limit: n, order: field} \\ %{limit: 20, order: :name}) do
    Player
    |> limit(^n)
    |> order_by(asc: ^field)
    |> Repo.all
  end

  def create_nation(attrs \\ %{}) do
    %Nation{}
    |> Nation.changeset(attrs)
    |> Repo.insert()
  end

  def get_nation(id), do: Repo.get(Nation, id)

  def create_league(attrs \\ %{}) do
    %League{}
    |> League.changeset(attrs)
    |> Repo.insert()
  end

  def get_league(id), do: Repo.get(League, id)

  def create_club(attrs \\ %{}) do
    %Club{}
    |> Club.changeset(attrs)
    |> Repo.insert()
  end

  def get_club(id), do: Repo.get(Club, id)

  def integrate_nation(%{id: id} = attrs) do
    case get_nation(id) do
      nil -> create_nation(attrs)
      %Nation{} = nation -> {:ok, nation}
    end
  end

  def integrate_league(%{id: id} = attrs) do
    case get_league(id) do
      nil -> create_league(attrs)
      %League{} = league -> {:ok, league}
    end
  end

  def integrate_club(%{id: id} = attrs) do
    case get_club(id) do
      nil -> create_club(attrs)
      %Club{} = club -> {:ok, club}
    end
  end

  def integrate_player(%{id: id} = attrs) do
    %{nation: nation, club: club, league: league} = attrs

    {:ok, nation} = integrate_nation(nation)
    {:ok, league} = integrate_league(league)
    {:ok, club} = club
    |> Map.put_new(:league_id, league.id)
    |> integrate_club()

    player_attrs = attrs
    |> Map.put_new(:nation_id, nation.id)
    |> Map.put_new(:club_id, club.id)

    case get_player(id) do
      nil -> create_player(player_attrs)
      %Player{} = player -> update_player(player, player_attrs)
    end
  end
end
