defmodule FutApi.GraphQL.Schema do
  use Absinthe.Schema
  alias FutApi.GraphQL.PlayerResolver

  object :player do
    field(:id, :id)
    field(:name, :string)
  end

  query do
    field :player, :player do
      arg(:id, non_null(:id))

      resolve &PlayerResolver.player_by_id/2
    end
  end
end
