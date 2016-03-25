defmodule StatusBoard.Repo.Migrations.CreateStatus do
  use Ecto.Migration

  def change do
    create table(:status) do
      add :user, :string
      add :state, :string
      add :project, :string
      add :notes, :string
      add :active, :boolean, default: false
      add :slackId, :string

      timestamps
    end

  end
end
