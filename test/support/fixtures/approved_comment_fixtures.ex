defmodule Crowdsourced.ApprovedCommentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Crowdsourced.ApprovedComment` context.
  """

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        commentor_id: 42,
        commets: "some commets",
        post_id: 42
      })
      |> Crowdsourced.ApprovedComment.create_comment()

    comment
  end
end
