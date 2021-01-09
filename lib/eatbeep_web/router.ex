defmodule EatbeepWeb.Router do
  use EatbeepWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {EatbeepWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Eatbeep.Plug.UserLookup
    plug Eatbeep.Plug.TenantLookup
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EatbeepWeb do
    pipe_through :browser

    live "/", PageLive, :index
    live "/signup", SignupLive, :index
    live "/menu", MenuLive, :index
    live "/login", LoginLive, :index
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
