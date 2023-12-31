defmodule First.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      FirstWeb.Telemetry,
      # Start the Ecto repository
      First.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: First.PubSub},
      # Start Finch
      {Finch, name: First.Finch},
      # Start the Endpoint (http/https)
      FirstWeb.Endpoint
      # Start a worker by calling: First.Worker.start_link(arg)
      # {First.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: First.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FirstWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
