defmodule Bank.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    DynamicSupervisor.start_link(Bank, [], strategy: :one_for_one, name: Bank)
  end
end
