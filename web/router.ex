defmodule StatusBoard.Router do
  use StatusBoard.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StatusBoard do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", StatusBoard do
    pipe_through :api

    post "/webhook", WebhookController, :submit
    resources "/status", StatusController, except: [:new, :edit]
  end
end
