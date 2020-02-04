defmodule FutApi.Importer.Parser do
  @doc """
    Transforms the player received from the FIFA API to a valid map
  """
  def parse_player(%{} = player) do
    %{"name" => name, "rating" => rating} = player

    %{name: name, rating: rating}
  end
end
