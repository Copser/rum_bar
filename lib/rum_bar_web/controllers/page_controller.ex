defmodule RumBarWeb.PageController do
  use RumBarWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
