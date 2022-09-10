defmodule CrowdsourcedWeb.CommentView do
  use CrowdsourcedWeb, :view
  alias CrowdsourcedWeb.CommentView

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{
      id: comment.id,
      commets: comment.commets,
      post_id: comment.post_id,
      commentor_id: comment.commentor_id
    }
  end
end
