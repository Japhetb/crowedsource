defmodule Crowdsourced.WaitingCommentTest do
  use Crowdsourced.DataCase

  alias Crowdsourced.WaitingComment

  describe "wcomments" do
    alias Crowdsourced.WaitingComment.Wcomment

    import Crowdsourced.WaitingCommentFixtures

    @invalid_attrs %{commentor_id: nil, commets: nil, no_votes: nil, post_id: nil, yes_votes: nil}

    test "list_wcomments/0 returns all wcomments" do
      wcomment = wcomment_fixture()
      assert WaitingComment.list_wcomments() == [wcomment]
    end

    test "get_wcomment!/1 returns the wcomment with given id" do
      wcomment = wcomment_fixture()
      assert WaitingComment.get_wcomment!(wcomment.id) == wcomment
    end

    test "create_wcomment/1 with valid data creates a wcomment" do
      valid_attrs = %{"commentor_id": 42, "commets": "some commets", "no_votes": 42, "post_id": 42, "yes_votes": 42}

      assert {:ok, %Wcomment{} = wcomment} = WaitingComment.create_wcomment(valid_attrs)
      assert wcomment.commentor_id == 42
      assert wcomment.commets == "some commets"
      assert wcomment.no_votes == 42
      assert wcomment.post_id == 42
      assert wcomment.yes_votes == 42
    end

    test "create_wcomment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = WaitingComment.create_wcomment(@invalid_attrs)
    end

    test "update_wcomment/2 with valid data updates the wcomment" do
      wcomment = wcomment_fixture()
      update_attrs = %{commentor_id: 43, commets: "some updated commets", no_votes: 43, post_id: 43, yes_votes: 43}

      assert {:ok, %Wcomment{} = wcomment} = WaitingComment.update_wcomment(wcomment, update_attrs)
      assert wcomment.commentor_id == 43
      assert wcomment.commets == "some updated commets"
      assert wcomment.no_votes == 43
      assert wcomment.post_id == 43
      assert wcomment.yes_votes == 43
    end

    test "update_wcomment/2 with invalid data returns error changeset" do
      wcomment = wcomment_fixture()
      assert {:error, %Ecto.Changeset{}} = WaitingComment.update_wcomment(wcomment, @invalid_attrs)
      assert wcomment == WaitingComment.get_wcomment!(wcomment.id)
    end

    test "delete_wcomment/1 deletes the wcomment" do
      wcomment = wcomment_fixture()
      assert {:ok, %Wcomment{}} = WaitingComment.delete_wcomment(wcomment)
      assert_raise Ecto.NoResultsError, fn -> WaitingComment.get_wcomment!(wcomment.id) end
    end

    test "change_wcomment/1 returns a wcomment changeset" do
      wcomment = wcomment_fixture()
      assert %Ecto.Changeset{} = WaitingComment.change_wcomment(wcomment)
    end
  end
end
