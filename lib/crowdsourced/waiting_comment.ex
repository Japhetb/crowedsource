defmodule Crowdsourced.WaitingComment do
  @moduledoc """
  The WaitingComment context.
  """

  import Ecto.Query, warn: false
  alias Crowdsourced.Repo

  alias Crowdsourced.WaitingComment.Wcomment
  alias Crowdsourced.ApprovedComment, as: ApprovedComment

  @doc """
  Returns the list of wcomments.

  ## Examples

      iex> list_wcomments()
      [%Wcomment{}, ...]

  """
  def list_wcomments do
    Repo.all(Wcomment)
  end

  @doc """
  Gets a single wcomment.

  Raises `Ecto.NoResultsError` if the Wcomment does not exist.

  ## Examples

      iex> get_wcomment!(123)
      %Wcomment{}

      iex> get_wcomment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_wcomment!(id), do: Repo.get(Wcomment, id)

  @doc """
  Creates a wcomment.

  ## Examples

      iex> create_wcomment(%{field: value})
      {:ok, %Wcomment{}}

      iex> create_wcomment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """


  def create_wcomment(attrs \\ %{}) do
    %Wcomment{}
    |> Wcomment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a wcomment.

  ## Examples

      iex> update_wcomment(wcomment, %{field: new_value})
      {:ok, %Wcomment{}}

      iex> update_wcomment(wcomment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
def update_yes_vote(%Wcomment{} = wcomment, attrs) do

  case fetch_yes_votes(attrs["id"]) do

  3 -> update_comment_table(wcomment)
  _ -> count = fetch_yes_votes(attrs["id"]) + 1
  attrs = %{yes_votes: count}
  wcomment
  |> Wcomment.changeset(attrs)
  |> Repo.update()
  end
end

def update_no_vote(%Wcomment{} = wcomment, attrs) do

  case fetch_no_votes(attrs["id"]) do
    3 -> delete_wcomment(attrs["id"])
    _ ->
      count = fetch_no_votes(attrs["id"]) + 1

      attrs = %{no_votes: count}

      wcomment
      |> Wcomment.changeset(attrs)
      |> Repo.update()
  end
end

  def update_wcomment(%Wcomment{} = wcomment, attrs) do
    wcomment
    |> Wcomment.changeset(attrs)
    |> Repo.update()
  end
  @doc """
  Returns yes votes
  """
  def fetch_yes_votes(id) do
    comments = get_wcomment!(id)
    comments.yes_votes
  end

  def fetch_no_votes(id) do
    comments = get_wcomment!(id)
    comments.no_votes
  end


  @doc """
  Deletes a wcomment.

  ## Examples

      iex> delete_wcomment(wcomment)
      {:ok, %Wcomment{}}

      iex> delete_wcomment(wcomment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_wcomment(id) do
    {:ok, wcomments} = get_wcomment!(id)
    Repo.delete(wcomments)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking wcomment changes.

  ## Examples

      iex> change_wcomment(wcomment)
      %Ecto.Changeset{data: %Wcomment{}}

  """
  def change_wcomment(%Wcomment{} = wcomment, attrs \\ %{}) do
    Wcomment.changeset(wcomment, attrs)
  end


  def update_comment_table(wcomment) do
    params = %{commentor_id: wcomment.commentor_id, commets: wcomment.commets, post_id: wcomment.post_id}

    case ApprovedComment.create_comment(params) do
      {:ok, _} -> {:ok, "Successfully created"}
      {:error, _} -> {:error, "not created"}
    end
    Repo.delete(wcomment)
  end

  def fetch_latest_comment_record() do
    Wcomment
    |> order_by(desc: :inserted_at)
    |> limit(1)
    |> Repo.all()
  end

end
