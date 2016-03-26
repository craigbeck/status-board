defmodule StatusBoard.WebhookController do
  use StatusBoard.Web, :controller
  require Logger
  alias StatusBoard.Status

  def submit(conn, params) do
    Logger.info "params > #{inspect params}"
    %{"text" => text, "token" => token, "user_id" => user_id, "user_name" => user_name} = params
    Logger.info "CMD > #{user_name} #{user_id} #{text}"
    if token != "Jrcl2JKRQlTWkU51kvjPeSZG" do
      json conn, %{text: "Ooops", attachments: [%{text: "Unauthorized! Check your integration token"}]}
    else
      {:ok, cmd} = parse_cmd(text)

      attrs = %{notes: cmd.text, project: cmd.project, state: to_string(cmd.status)}

      result =
        case Repo.get_by(Status, slackId: user_id, active: true) do
          nil -> %Status{ user: user_name, slackId: user_id }
          status -> status
        end
        |> Status.changeset(attrs)
        |> Repo.insert_or_update


      case result do
        {:ok, status} ->
          payload = status
            |> Map.from_struct
            |> sanitize_fields
          StatusBoard.Endpoint.broadcast! "status:lobby", "update", %{status: payload}
          json conn, %{
            text: "Status updated for #{user_name}",
            attachments: [
              %{text: "Status -> #{cmd.status} project -> #{cmd.project} notes -> #{cmd.text}"},
            ]
          }
        {:error, changeset} ->
          Logger.info "could not save -> #{inspect changeset}"
          json conn, %{
            text: "Oops!",
            attachments: [
              %{text: "Could not update your status"}
            ]
          }
      end
    end
  end

  defp sanitize_fields(map) do
    Map.drop(map, [:__meta__, :__struct__])
  end

  def parse_cmd(cmd) do
    cmd
    |> parse_status
    |> parse_project
  end

  def parse_status(cmd) do
    case cmd do
      "wfh" <> " " <> text -> {:ok, %{status: :wfh, text: text}}
      "blocked" <> " " <> text -> {:ok, %{status: :blocked, text: text}}
      "ooo" <> " " <> text -> {:ok, %{status: :ooo, text: text}}
      "idle" <> " " <> text -> {:ok, %{status: :idle, text: text}}
      text -> {:ok, %{status: :ok, text: text}}
    end
  end

  def parse_project({:ok, cmd}) do
    [head | tail] = String.split(cmd.text, " ")
    case head do
      "#" <> project -> {:ok, Map.put(Map.put(cmd, :text, Enum.join(tail, " ")), :project, project)}
      _ -> {:ok, Map.put(cmd, :project, nil)}
    end
  end
end
