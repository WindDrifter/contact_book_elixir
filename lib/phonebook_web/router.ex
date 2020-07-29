defmodule PhonebookWeb.Router do
  use PhonebookWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end
  scope "/" do
    pipe_through :api
    forward "/graphql", Absinthe.Plug,
      schema: PhonebookWeb.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: PhonebookWeb.Schema,
      socket: PhonebookWeb.UserSocket,
      interface: :playground

  end
  scope "/api", PhonebookWeb do
    pipe_through :api
  end

end
