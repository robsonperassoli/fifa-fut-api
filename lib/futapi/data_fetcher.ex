defmodule FutApi.DataFetcher do
  alias FutApi.Fifa

  def fetch() do
    {:ok, response} = Fifa.get_players()
    %{body: body} = response
    %{"items" => items} = body
    [first | _rest] = items
    first
  end
end
