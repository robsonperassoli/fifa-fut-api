defmodule FutApi.Fifa do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://www.easports.com/fifa/ultimate-team/api/fut"
  plug Tesla.Middleware.JSON

  def get_players(page \\ 1) do
    get("/item?page=#{page}")
  end
end
