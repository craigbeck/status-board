defmodule StatusBoard.Status do
  use StatusBoard.Web, :model

  schema "status" do
    field :user, :string
    field :state, :string, default: "idle"
    field :project, :string, default: nil
    field :notes, :string, default: nil
    field :active, :boolean, default: true
    field :slackId, :string

    timestamps
  end

  @required_fields ~w(user slackId)
  @optional_fields ~w(state project notes active)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
