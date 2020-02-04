defmodule FutApi.Fifa do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://www.easports.com/fifa/ultimate-team/api/fut"
  plug Tesla.Middleware.JSON

  defp parse_response({:ok, response}) do
    %{body: body} = response
    %{
      "items" => items,
      "page" => page,
      "totalPages" => total_pages
    } = body

    %{
      items: items,
      page: page,
      total_pages: total_pages
    }
  end

  def get_players(page \\ 1) do
    get("/item?page=#{page}")
    |> parse_response()
  end
end
