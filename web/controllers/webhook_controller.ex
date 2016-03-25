defmodule StatusBoard.WebhookController do
  use StatusBoard.Web, :controller
  require Logger

  def submit(conn, params) do
    Logger.info "params > #{inspect params}"
    %{"text" => text, "token" => token, "user_id" => user_id, "user_name" => user_name} = params
    Logger.info "CMD > #{user_name} #{user_id} #{text}"
    if token != "Jrcl2JKRQlTWkU51kvjPeSZG" do
      json conn, %{text: "Ooops", attachments: [%{text: "Unauthorized! Check your integration token"}]}
    else
      {:ok, cmd} = parse_cmd(text)
      json conn, %{
        text: "Status updated for #{user_name}",
        attachments: [
          %{text: "Status -> #{cmd.status}"},
          %{text: "Notes -> #{cmd.text}"}
        ]
      }
    end
  end

  def parse_cmd(cmd) do
    case cmd do
      "wfh" <> " " <> text -> {:ok, %{status: :wfh, text: text}}
      "blocked" <> " " <> text -> {:ok, %{status: :blocked, text: text}}
      "ooo" <> " " <> text -> {:ok, %{status: :ooo, text: text}}
      text -> {:ok, %{status: :ok, text: text}}
    end
  end
end
