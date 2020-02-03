defmodule FutApi.Fifa do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://www.easports.com/fifa/ultimate-team/api/fut"
  plug Tesla.Middleware.JSON

  def get_players do
    get("/item")
  end

  def get_players(name) do
    get("/item?name=#{name}")
  end
end
