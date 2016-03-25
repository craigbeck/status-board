defmodule StatusBoard.PageController do
  use StatusBoard.Web, :controller
  require Logger

  alias StatusBoard.Status

  def index(conn, _params) do
    status = Repo.all(Status)
    Logger.debug "Status -> #{inspect status}"
    render conn, "index.html", status: status
  end
end
