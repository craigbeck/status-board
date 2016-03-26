defmodule StatusBoard.PageController do
  use StatusBoard.Web, :controller

  alias StatusBoard.Status

  def index(conn, _params) do
    render conn, "index.html"
  end
end
