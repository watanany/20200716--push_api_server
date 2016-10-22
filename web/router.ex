defmodule PushApiServer.Router do
  use PushApiServer.Web, :router

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

  scope "/", PushApiServer do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/projects", ProjectController
    resources "/requests", RequestController
    resources "/parameters", ParameterController

    resources "/users", UserController do
      resources "/projects", ProjectController
    end

    resources "/applications", ApplicationController do
      resources "/requests", RequestController do
        resources "/parameters", ParameterController
      end
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", PushApiServer do
    pipe_through :api
  end
end
