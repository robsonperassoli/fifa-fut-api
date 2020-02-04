defmodule FutApi.Importer.Parser do
  defp create_map([], map), do: map

  defp create_map([entry | entries], map) do
    %{k: key, v: value} = entry
    new_map = Map.put(map, String.to_atom(key), value)
    create_map(entries, new_map)
  end

  @doc """
    Transforms the player received from the FIFA API to a valid map

    ## Examples

      iex> %{"name" => "Cristiano Ronaldo", "rating" => 99, "id" => 12039} |> FutApi.Importer.Parser.parse_player()
      %{id: 12039, name: "Cristiano Ronaldo", rating: 99}
  """
  def parse_player(%{} = player) do
    fields = ["id", "name", "rating"]

    fields
    |> Enum.map(fn k -> %{k: k, v: Map.get(player, k)} end)
    |> create_map(%{})
  end
end
