defmodule Crowdsourced.WaitingCommentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Crowdsourced.WaitingComment` context.
  """

  @doc """
  Generate a wcomment.
  """
  def wcomment_fixture(attrs \\ %{}) do
    {:ok, wcomment} =
      attrs
      |> Enum.into(%{
        commentor_id: 42,
        commets: "some commets",
        no_votes: 42,
        post_id: 42,
        yes_votes: 42
      })
      |> Crowdsourced.WaitingComment.create_wcomment()

    wcomment
  end
end
