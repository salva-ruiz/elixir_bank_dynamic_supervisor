# Bank

An example of `DynamicSupervisor` using the `Bank` module as supervisor and
`Bank.Account` as children processes.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `bank` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bank, "~> 1.0.0"}
  ]
end
```

## Documentation

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/bank>.

## Testing

Execute `mix test` from the command line.
