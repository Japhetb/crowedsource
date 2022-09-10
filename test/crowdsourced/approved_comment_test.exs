defmodule Crowdsourced.ApprovedCommentTest do
  use Crowdsourced.DataCase

  alias Crowdsourced.ApprovedComment

  describe "comments" do
    alias Crowdsourced.ApprovedComment.Comment

    import Crowdsourced.ApprovedCommentFixtures

    @invalid_attrs %{commentor_id: nil, commets: nil, post_id: nil}

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert ApprovedComment.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert ApprovedComment.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      valid_attrs = %{commentor_id: 42, commets: "some commets", post_id: 42}

      assert {:ok, %Comment{} = comment} = ApprovedComment.create_comment(valid_attrs)
      assert comment.commentor_id == 42
      assert comment.commets == "some commets"
      assert comment.post_id == 42
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ApprovedComment.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      update_attrs = %{commentor_id: 43, commets: "some updated commets", post_id: 43}

      assert {:ok, %Comment{} = comment} = ApprovedComment.update_comment(comment, update_attrs)
      assert comment.commentor_id == 43
      assert comment.commets == "some updated commets"
      assert comment.post_id == 43
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = ApprovedComment.update_comment(comment, @invalid_attrs)
      assert comment == ApprovedComment.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = ApprovedComment.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> ApprovedComment.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = ApprovedComment.change_comment(comment)
    end
  end
end
