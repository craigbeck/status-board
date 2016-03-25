use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :status_board, StatusBoard.Endpoint,
  secret_key_base: "JbMX/6i6QjO2ICUPEZEjF4UWIDRYIqpYHsBC3FXniIzWKeqolv0S0Q5/UUSBXHVg"

# Configure your database
config :status_board, StatusBoard.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "status_board_prod",
  pool_size: 20
