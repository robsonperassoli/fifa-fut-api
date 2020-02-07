defmodule FutApi.Importer.Parser do

  def parse_club(%{raw: raw, player: player} = data) do
    %{
      "club" => %{
        "id" => id,
        "name" => name,
        "imageUrls" => %{
          "dark" => %{
            "medium" => image_url
          }
        }
      }
    } = raw

    club = %{id: id, name: name, image_url: image_url}
    %{data | player: %{player | club: club}}
  end

  def parse_league(%{raw: raw, player: player} = data) do
    %{
      "league" => %{
        "id" => id,
        "name" => name,
        "imageUrls" => %{
          "dark" => image_url
        }
      }
    } = raw

    league = %{id: id, name: name, image_url: image_url}
    %{data | player: %{player | league: league}}
  end

  def parse_nation(%{raw: raw, player: player} = data) do
    %{
      "nation" => %{
        "id" => id,
        "name" => name,
        "imageUrls" => %{
          "medium" => image_url
        }
      }
    } = raw

    nation = %{id: id, name: name, image_url: image_url}
    %{data | player: %{player | nation: nation}}
  end

  @doc """
    Transforms the player received from the FIFA API to a valid map

    ## Examples

      iex> %{"name" => "Cristiano Ronaldo", "rating" => 99, "id" => 12039} |> FutApi.Importer.Parser.parse_player()
      %{id: 12039, name: "Cristiano Ronaldo", rating: 99}
  """
  def parse_player(%{} = raw_player) do
    %{
      "id" => id,
      "name" => name,
      "rating" => rating,
      "baseId" => base_id,
      "weakFoot" => weak_foot,
      "foot" => foot,
      "position" => position,
      } = raw_player

    player = %{
      id: id,
      name: name,
      rating: rating,
      base_id: base_id,
      weak_foot: weak_foot,
      foot: foot,
      position: position,
      club: nil,
      league: nil,
      nation: nil
    }

    %{raw: raw_player, player: player}
    |> parse_nation()
    |> parse_club()
    |> parse_league()
    |> Map.get(:player)
  end


end
