defmodule StatusBoard.WebhookControllerTest do
  use StatusBoard.ConnCase

  test "GET /api/webhook", %{conn: conn} do
    formData = %{
      token: "Jrcl2JKRQlTWkU51kvjPeSZG",
      text: nil,
      user_id: "U12345",
      user_name: "developer"
    }
    conn = post conn, webhook_path(conn, :submit), formData
    assert json_response(conn, 200)["text"]
  end

  test "invalid token", %{conn: conn} do
    formData = %{
      token: "some_invalid_token",
      text: nil,
      user_id: "U12345",
      user_name: "developer"
    }
    conn = post conn, webhook_path(conn, :submit), formData
    assert json_response(conn, 200)["text"] =~ "Ooops"
  end

  test "parse blocked" do
    res = StatusBoard.WebhookController.parse_cmd("blocked #admin fixing api packages limits")
    assert {:ok, cmd} = res
    assert cmd
    assert cmd.status == :blocked
    assert cmd.text == "#admin fixing api packages limits"
  end
end
