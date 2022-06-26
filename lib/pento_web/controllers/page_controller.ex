defmodule PentoWeb.PageController do
  use PentoWeb, :controller

  def index(conn, _params) do
    if conn.assigns[:current_user] do
      IO.inspect(Routes.live_path(conn, PentoWeb.WrongLive))
      conn |> redirect(to: Routes.live_path(conn, PentoWeb.WrongLive)) |> halt()
    else
      render(conn, "index.html")
    end
  end
end
