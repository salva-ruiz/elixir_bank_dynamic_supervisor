defmodule Bank.Account do
  @moduledoc """
  A module that uses an Agent process to store a bank account state and defines
  related functions.
  """

  use Agent

  @type t :: %Bank.Account{name: String.t(), balance: non_neg_integer}

  @enforce_keys [:name, :balance]
  defstruct [:name, :balance]

  @spec start_link(account :: Bank.Account.t()) :: {:ok, pid}
  def start_link(%__MODULE__{balance: balance} = account) when balance >= 0 do
    Agent.start_link(fn -> account end)
  end

  @doc "Get the state of the bank account stored in the Agent process."
  @spec status(pid :: pid) :: Bank.Account.t()
  def status(pid) when is_pid(pid) do
    Agent.get(pid, fn account -> account end)
  end

  @doc "Get the name of the bank account owner."
  @spec name(pid :: pid) :: String.t()
  def name(pid) when is_pid(pid) do
    Agent.get(pid, fn account -> account.name end)
  end

  @doc "Get the balance of the bank account."
  @spec balance(pid :: pid) :: integer
  def balance(pid) when is_pid(pid) do
    Agent.get(pid, fn account -> account.balance end)
  end

  @doc "Deposit an amount of money in the bank account."
  @spec deposit(pid :: pid, amount :: non_neg_integer) :: :ok
  def deposit(pid, amount) when is_pid(pid) and amount > 0 do
    Agent.update(pid, fn account -> %{account | balance: account.balance + amount} end)
  end

  @doc "Withdraw an amount of money from a bank account."
  @spec withdraw(pid :: pid, amount :: non_neg_integer) :: :ok | {:error, :not_enough_funds}
  def withdraw(pid, amount) when is_pid(pid) and amount > 0 do
    if balance(pid) - amount < 0 do
      {:error, :not_enough_funds}
    else
      Agent.update(pid, fn account -> %{account | balance: account.balance - amount} end)
    end
  end

  defimpl String.Chars do
    @spec to_string(%Bank.Account{}) :: String.t()
    def to_string(%Bank.Account{name: name, balance: balance}) do
      "The balance of #{name} account is #{balance} euros."
    end
  end
end
