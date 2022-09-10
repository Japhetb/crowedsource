defmodule CrowdsourcedWeb.WcommentView do
  use CrowdsourcedWeb, :view
  alias CrowdsourcedWeb.WcommentView

  def render("index.json", %{wcomments: wcomments}) do
    %{data: render_many(wcomments, WcommentView, "wcomment.json")}
  end

  def render("show.json", %{wcomment: wcomment}) do
    %{data: render_one(wcomment, WcommentView, "wcomment.json")}
  end

  def render("wcomment.json", %{wcomment: wcomment}) do
    %{
      id: wcomment.id,
      commets: wcomment.commets,
      post_id: wcomment.post_id,
      yes_votes: wcomment.yes_votes,
      no_votes: wcomment.no_votes,
      commentor_id: wcomment.commentor_id
    }
  end

  def render("error.json", %{error: ""}) do
    %{
      error: "Comments not found"
    }
  end
end
