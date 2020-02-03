defmodule FutApi.Endpoint do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)

  plug(
    Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Jason
  )

  # plug(Absinthe.Plug, schema: FutApi.Schema)

  plug(:dispatch)

  forward("/graphql",
    to: Absinthe.Plug,
    init_opts: [schema: FutApi.Schema]
  )

  forward("graphiql",
    to: Absinthe.Plug.GraphiQL,
    init_opts: [schema: FutApi.Schema]
  )

  get "/ping" do
    send_resp(conn, 200, "Pong!")
  end

  match _ do
    send_resp(conn, 404, "oops, not found!")
  end
end
