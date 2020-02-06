defmodule FutApi.ImporterSupervisor do
  use Supervisor

  def start_link(_args) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @spec init(:ok) :: {:ok, {%{intensity: any, period: any, strategy: any}, [any]}}
  def init(:ok) do
    children = [
      FutApi.Importer.PlayersQueue,
      FutApi.Importer,
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
