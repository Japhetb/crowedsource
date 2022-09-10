defmodule Crowdsourced.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :commets, :string
      add :post_id, :integer
      add :commentor_id, :integer

      timestamps()
    end
  end
end
