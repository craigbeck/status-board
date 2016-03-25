ExUnit.start

Mix.Task.run "ecto.create", ~w(-r StatusBoard.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r StatusBoard.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(StatusBoard.Repo)

