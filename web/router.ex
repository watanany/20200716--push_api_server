defmodule PushApiServer.Router do
  use PushApiServer.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authorization do
    plug PushApiServer.Plugs.CurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PushApiServer do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index, as: :root

    get "/signup", RegistrationController, :new, as: :signup
    get "/signin", SessionController, :new, as: :signin

    resources "/registrations", RegistrationController, only: [:new, :create]
    resources "/passwords", PasswordController
    resources "/sessions", SessionController

  end

  scope "/", PushApiServer do
    pipe_through [:browser, :authorization]

    resources "/projects", ProjectController
    resources "/pushes", PushController
    resources "/parameters", ParameterController

    resources "/users", UserController do
      resources "/projects", ProjectController
    end

    resources "/applications", ApplicationController do
      resources "/pushes", PushController do
        resources "/parameters", ParameterController
      end
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", PushApiServer do
    pipe_through :api
  end
end
