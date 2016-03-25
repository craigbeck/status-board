defmodule StatusBoard.WebhookControllerTest do
  use StatusBoard.ConnCase

  test "GET /api/webhook", %{conn: conn} do
    formData = %{
      token: "Jrcl2JKRQlTWkU51kvjPeSZG",
      text: "foo bar",
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
    assert json_response(conn, 200)["text"]
  end

  test "parse blocked" do
    res = StatusBoard.WebhookController.parse_cmd("blocked #admin fixing api packages limits")
    assert {:ok, cmd} = res
    assert cmd.status == :blocked
    assert cmd.text == "fixing api packages limits"
  end

  test "parse wfh" do
    res = StatusBoard.WebhookController.parse_cmd("wfh #admin fixing api packages limits")
    assert {:ok, cmd} = res
    assert cmd.status == :wfh
    assert cmd.text == "fixing api packages limits"
  end

  test "parse ooo" do
    res = StatusBoard.WebhookController.parse_cmd("ooo #admin fixing api packages limits")
    assert {:ok, cmd} = res
    assert cmd.status == :ooo
    assert cmd.text == "fixing api packages limits"
  end

  test "parse non-matching status" do
    res = StatusBoard.WebhookController.parse_cmd("foo #admin fixing api packages limits")
    assert {:ok, cmd} = res
    assert cmd.status == :ok
    assert cmd.text == "foo #admin fixing api packages limits"
  end

  test "parse project" do
    res = StatusBoard.WebhookController.parse_cmd("#admin fixing api")
    assert {:ok, cmd} = res
    assert cmd.status == :ok
    assert cmd.project == "admin"
    assert cmd.text == "fixing api"
  end
end
