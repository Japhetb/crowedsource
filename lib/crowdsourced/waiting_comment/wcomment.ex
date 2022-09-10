defmodule Crowdsourced.WaitingComment.Wcomment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wcomments" do
    field :commentor_id, :integer
    field :commets, :string
    field :no_votes, :integer, default: 0
    field :post_id, :integer
    field :yes_votes, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(wcomment, attrs) do
    wcomment
    |> cast(attrs, [:commets, :post_id, :yes_votes, :no_votes, :commentor_id])
    |> validate_required([:commets, :post_id, :yes_votes, :no_votes, :commentor_id])
  end
end
