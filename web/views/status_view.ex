defmodule StatusBoard.StatusView do
  use StatusBoard.Web, :view

  def render("index.json", %{status: status}) do
    %{data: render_many(status, StatusBoard.StatusView, "status.json")}
  end

  def render("show.json", %{status: status}) do
    %{data: render_one(status, StatusBoard.StatusView, "status.json")}
  end

  def render("status.json", %{status: status}) do
    %{id: status.id,
      user: status.user,
      state: status.state,
      project: status.project,
      notes: status.notes,
      active: status.active,
      slackId: status.slackId}
  end
end
