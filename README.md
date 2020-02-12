# FutApi
This is a data fetcher and GraphQL API based on EA Sports Fifa Ultimate team data

## Stack
Built using Elixir with Cowboy and Absinthe

## Running
1. Execute ```mix ecto.create``` and ```mix ecto.migrate``` to setup the database.
2. Start the with ```mix run --no-halt``` (the first execution will download the data from official fifa api).
3. The app starts on port 4001 by default, the graphl endpoint is: `http://localhost:4001/graphql`.
4. You can test the queries using the graphical interface using: `http://localhost:4001/graphiql`

## Demo
![Reports](/img/query.gif)
