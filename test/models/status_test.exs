defmodule StatusBoard.StatusTest do
  use StatusBoard.ModelCase

  alias StatusBoard.Status

  @valid_attrs %{active: true, notes: "some content", project: "some content", slackId: "some content", state: "some content", user: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Status.changeset(%Status{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Status.changeset(%Status{}, @invalid_attrs)
    refute changeset.valid?
  end
end
