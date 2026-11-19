# status-board

An Elixir/Phoenix app that lets team members update their developer status via Slack slash
commands, then displays those statuses in real-time on a dashboard using Phoenix Channels.

## Features

- Set your status from Slack with a simple slash command
- Status types: `ok`, `wfh` (working from home), `blocked`, `ooo` (out of office), `idle`
- Optional project tag and free-text notes
- Real-time dashboard — updates push to all viewers instantly over WebSocket

## Prerequisites

- Elixir 1.0+ / Erlang OTP 18+
- PostgreSQL
- Node.js (for asset compilation)

## Setup

```sh
# Install Elixir dependencies
mix deps.get

# Create and migrate the database
mix ecto.create && mix ecto.migrate

# Install Node.js dependencies
npm install
```

### Configure the Slack slash command token

The webhook token is currently hardcoded in
`web/controllers/webhook_controller.ex`. Before deploying, replace the value
in the `if token != "..."` check with your own token from the Slack integration
settings (or extract it to an environment variable).

### Create the Slack slash command

1. Go to your Slack workspace's **App & Integrations** settings.
2. Add a new **Slash Commands** integration.
3. Set the **Command** to `/status` (or any name you prefer).
4. Set the **URL** to `https://<your-host>/api/webhook`.
5. Set **Method** to `POST`.
6. Copy the **Token** shown and update it in `webhook_controller.ex`.

## Running

```sh
mix phoenix.server
```

The dashboard is at `http://localhost:4000`.

## Slash command syntax

```
/status <state> [#project] [notes]
```

| State | Meaning |
|---|---|
| `ok` | Available / working normally |
| `wfh` | Working from home |
| `blocked` | Blocked and waiting |
| `ooo` | Out of office |
| `idle` | Idle / no active work |

**Examples**

```
/status ok
/status wfh just catching up on email
/status blocked #api-service waiting on deploy
/status ooo back Monday
```

## API endpoints

| Method | Path | Description |
|---|---|---|
| `POST` | `/api/webhook` | Slack slash command receiver |
| `GET` | `/api/status` | List all current statuses |
| `GET` | `/api/status/:id` | Get a single status |
| `DELETE` | `/api/status/:id` | Delete a status |
