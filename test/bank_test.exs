defmodule BankTest do
  use ExUnit.Case
  doctest Bank

  test "creates a new bank account" do
    assert match?({:ok, _pid}, new_account())
  end

  test "close a bank account" do
    {:ok, pid} = new_account()
    assert Bank.close_account(pid) == :ok
  end

  test "get the total of the bank accounts" do
    new_account("John", 5)
    new_account("Peter", 8)
    assert Bank.total() == 13
  end

  defp new_account(name \\ "John", balance \\ 0) do
    Bank.new_account(name, balance)
  end
end
