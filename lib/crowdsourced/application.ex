defmodule Crowdsourced.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Crowdsourced.Repo,
      # Start the Telemetry supervisor
      CrowdsourcedWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Crowdsourced.PubSub},
      # Start the Endpoint (http/https)
      CrowdsourcedWeb.Endpoint
      # Start a worker by calling: Crowdsourced.Worker.start_link(arg)
      # {Crowdsourced.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Crowdsourced.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CrowdsourcedWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
