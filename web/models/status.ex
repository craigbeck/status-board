defmodule StatusBoard.Status do
  use StatusBoard.Web, :model

  schema "status" do
    field :user, :string
    field :state, :string
    field :project, :string
    field :notes, :string
    field :active, :boolean, default: false
    field :slackId, :string

    timestamps
  end

  @required_fields ~w(user state project notes active slackId)
  @optional_fields ~w()

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
