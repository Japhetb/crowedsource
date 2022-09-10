defmodule CrowdsourcedWeb.WcommentControllerTest do
  use CrowdsourcedWeb.ConnCase

  import Crowdsourced.WaitingCommentFixtures

  alias Crowdsourced.WaitingComment.Wcomment

  @create_attrs %{
    commentor_id: 42,
    commets: "some commets",
    no_votes: 42,
    post_id: 42,
    yes_votes: 42
  }
  @update_attrs %{
    commentor_id: 43,
    commets: "some updated commets",
    no_votes: 43,
    post_id: 43,
    yes_votes: 43
  }
  @invalid_attrs %{commentor_id: nil, commets: nil, no_votes: nil, post_id: nil, yes_votes: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all wcomments", %{conn: conn} do
      conn = get(conn, Routes.wcomment_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create wcomment" do
    test "renders wcomment when data is valid", %{conn: conn} do
      conn = post(conn, Routes.wcomment_path(conn, :create), wcomment: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.wcomment_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "commentor_id" => 42,
               "commets" => "some commets",
               "no_votes" => 42,
               "post_id" => 42,
               "yes_votes" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.wcomment_path(conn, :create), wcomment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update wcomment" do
    setup [:create_wcomment]

    test "renders wcomment when data is valid", %{conn: conn, wcomment: %Wcomment{id: id} = wcomment} do
      conn = put(conn, Routes.wcomment_path(conn, :update, wcomment), wcomment: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.wcomment_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "commentor_id" => 43,
               "commets" => "some updated commets",
               "no_votes" => 43,
               "post_id" => 43,
               "yes_votes" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, wcomment: wcomment} do
      conn = put(conn, Routes.wcomment_path(conn, :update, wcomment), wcomment: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete wcomment" do
    setup [:create_wcomment]

    test "deletes chosen wcomment", %{conn: conn, wcomment: wcomment} do
      conn = delete(conn, Routes.wcomment_path(conn, :delete, wcomment))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.wcomment_path(conn, :show, wcomment))
      end
    end
  end

  defp create_wcomment(_) do
    wcomment = wcomment_fixture()
    %{wcomment: wcomment}
  end
end
