defmodule Crowdsourced.Repo do
  use Ecto.Repo,
    otp_app: :crowdsourced,
    adapter: Ecto.Adapters.Postgres
end
