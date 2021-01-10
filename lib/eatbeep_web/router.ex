defmodule EatbeepWeb.Router do
  use EatbeepWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {EatbeepWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :tenant do
    plug Eatbeep.Plug.TenantLookup
    plug Eatbeep.Plug.Login
  end

  pipeline :logged_in do
    plug Eatbeep.Plug.EnsureLoggedIn
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EatbeepWeb, host: "www." do
    pipe_through :browser

    live "/", PageLive, :index
    live "/signup", SignupLive, :index
  end

  scope "/", EatbeepWeb do
    pipe_through [:browser, :tenant]

    live "/", MenuLive, :index
    live "/login", LoginLive, :index

    pipe_through [:logged_in]
    live "/menu", EditorLive, :index
  end



  # Other scopes may use custom stacks.
  # scope "/api", EatbeepWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: EatbeepWeb.Telemetry
    end
  end
end
