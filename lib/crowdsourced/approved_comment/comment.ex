defmodule Crowdsourced.ApprovedComment.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :commentor_id, :integer
    field :commets, :string
    field :post_id, :integer

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:commets, :post_id, :commentor_id])
    |> validate_required([:commets, :post_id, :commentor_id])
  end
end
