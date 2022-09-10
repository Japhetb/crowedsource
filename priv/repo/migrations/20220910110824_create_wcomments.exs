defmodule Crowdsourced.Repo.Migrations.CreateWcomments do
  use Ecto.Migration

  def change do
    create table(:wcomments) do
      add :commets, :string
      add :post_id, :integer
      add :yes_votes, :integer
      add :no_votes, :integer
      add :commentor_id, :integer

      timestamps()
    end
  end
end
