defmodule Bank do
  @moduledoc """
  A DynamicSupervisor module and bank accounts related functions.
  """

  use DynamicSupervisor

  @impl true
  def init(args) do
    DynamicSupervisor.init(args)
  end

  @doc "Creates a new bank account with the owner name and optional balance."
  @spec new_account(name :: String.t(), balance :: non_neg_integer) :: :ok
  def new_account(name, balance \\ 0)
      when is_binary(name) and is_integer(balance) and balance >= 0 do
    account = %Bank.Account{
      name: name,
      balance: balance
    }

    DynamicSupervisor.start_child(Bank, {Bank.Account, account})
  end

  @doc "Close an existent bank account."
  @spec close_account(pid :: pid) :: :ok
  def close_account(pid) when is_pid(pid) do
    DynamicSupervisor.terminate_child(Bank, pid)
  end

  @doc "Prints out the list of banks accounts."
  @spec accounts() :: :ok
  def accounts do
    pids()
    |> Enum.map(fn pid -> Bank.Account.status(pid) end)
    |> Enum.join("\n")
    |> IO.puts()
  end

  @doc "Get the total of the bank accounts."
  @spec total() :: non_neg_integer
  def total do
    pids()
    |> Enum.map(fn pid -> Bank.Account.balance(pid) end)
    |> Enum.sum()
  end

  defp pids do
    Bank
    |> DynamicSupervisor.which_children()
    |> Enum.map(fn {_, pid, _, [Bank.Account]} -> pid end)
  end
end
