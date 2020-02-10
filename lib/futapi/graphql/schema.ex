defmodule FutApi.GraphQL.Schema do
  use Absinthe.Schema
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]
  alias FutApi.GraphQL.PlayerResolver
  alias FutApi.Fut

  def context(ctx) do
    loader = Dataloader.new() |> Dataloader.add_source(:fut, Fut.data())

    ctx
    |> Map.put(:loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end

  object :nation do
    field :id, :id
    field :name, :string
  end

  object :league do
    field :id, :id
    field :name, :string
  end

  object :club do
    field :id, :id
    field :name, :string
    field :league, :league, resolve: dataloader(:fut)
  end

  object :player do
    field :id, :id
    field :name, :string
    field :nation, :nation, resolve: dataloader(:fut)
    field :club, :club, resolve: dataloader(:fut)
  end

  query do
    field :player, :player do
      arg(:id, non_null(:id))

      resolve &PlayerResolver.player_by_id/2
    end

    field :players, list_of(:player) do
      resolve &PlayerResolver.players_list/2
    end
  end
end
