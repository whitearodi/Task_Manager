defmodule TaskApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TaskAppWeb.Telemetry,
      # Start the Ecto repository
      TaskApp.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: TaskApp.PubSub},
      # Start Finch
      {Finch, name: TaskApp.Finch},
      # Start the Endpoint (http/https)
      TaskAppWeb.Endpoint,
      # Start a worker by calling: TaskApp.Worker.start_link(arg)
      # {TaskApp.Worker, arg}
      {Oban, Application.fetch_env!(:task_app, Oban)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TaskApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # lib/task_app/application.ex
  # def start(_type, _args) do
  #   children =[
  #     TaskApp.Repo,

  #   ]
  # end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TaskAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
