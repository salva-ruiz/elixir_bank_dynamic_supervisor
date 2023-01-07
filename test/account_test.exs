defmodule AccountTest do
  use ExUnit.Case
  doctest Bank

  test "creates a new bank account" do
    assert match?({:ok, _pid}, new_account())
  end

  test "returns an error if the balance of a new bank account is not valid" do
    assert_raise FunctionClauseError, fn ->
      new_account("Peter", -1)
    end
  end

  test "get the status of a bank account" do
    {:ok, pid} = new_account()
    assert match?(%{name: "John", balance: 10}, Bank.Account.status(pid))
  end

  test "get the name of a bank account owner" do
    {:ok, pid} = new_account()
    assert Bank.Account.name(pid) == "John"
  end

  test "get the balance of a bank account" do
    {:ok, pid} = new_account()
    assert Bank.Account.balance(pid) == 10
  end

  test "when deposit money, the balance of a bank account is modified properly" do
    {:ok, pid} = new_account()
    Bank.Account.deposit(pid, 3)
    assert Bank.Account.balance(pid) == 13
  end

  test "when withdraw money, the balance of a bank account is modified properly" do
    {:ok, pid} = new_account()
    Bank.Account.withdraw(pid, 3)
    assert Bank.Account.balance(pid) == 7
  end

  defp new_account(name \\ "John", balance \\ 10) do
    Bank.Account.start_link(%Bank.Account{name: name, balance: balance})
  end
end
