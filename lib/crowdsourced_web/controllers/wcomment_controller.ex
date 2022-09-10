defmodule CrowdsourcedWeb.WcommentController do
  use CrowdsourcedWeb, :controller

  alias Crowdsourced.WaitingComment
  alias Crowdsourced.WaitingComment.Wcomment

  action_fallback CrowdsourcedWeb.FallbackController

  def index(conn, _params) do
    wcomments = WaitingComment.list_wcomments()
    render(conn, "index.json", wcomments: wcomments)
  end

  def create(conn, wcomment_params) do
    with {:ok, %Wcomment{} = wcomment} <- WaitingComment.create_wcomment(wcomment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.wcomment_path(conn, :show, wcomment))
      |> render("show.json", wcomment: wcomment)
    end
  end

  def update_votes(conn, params) do
    wcomments = WaitingComment.get_wcomment!(params["id"])

    case  wcomments do
      nil ->  conn |> CrowdsourcedWeb.FallbackController.call("Not found")
      _ ->
        case params["vote"] do
          "yes" -> WaitingComment.update_yes_vote(wcomments, params)
          "no" -> WaitingComment.update_no_vote(wcomments, params)
        end
        send_resp(conn, :no_content, "")
    end
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    wcomment = WaitingComment.get_wcomment!(id)
    render(conn, "show.json", wcomment: wcomment)
  end

  def update(conn, %{"id" => id, "wcomment" => wcomment_params}) do
    {:ok, wcomment} = WaitingComment.get_wcomment!(id)

    with {:ok, %Wcomment{} = wcomment} <- WaitingComment.update_wcomment(wcomment, wcomment_params) do
      render(conn, "show.json", wcomment: wcomment)
    end
  end

  def delete(conn, %{"id" => id}) do
    wcomment = WaitingComment.get_wcomment!(id)

    with {:ok, %Wcomment{}} <- WaitingComment.delete_wcomment(wcomment) do
      send_resp(conn, :no_content, "")
    end
  end

  def show_latest_comment(conn, _params) do
    wcomments = WaitingComment.fetch_latest_comment_record()
    render(conn, "index.json", wcomments: wcomments)
  end


#   creat
#   curl --location --request GET 'http://localhost:4000/api/wcomments' \
# --header 'Content-Type: application/json' \
# --data-raw '{"commentor_id": 42, "commets": "some www comments", "post_id": 42}'

# curl --location --request POST 'http://localhost:4000/api/update_votes' \
# --header 'Content-Type: application/json' \
# --data-raw '{"vote": "no", "id": 2}'
end
