defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  use Rocketpay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "Test",
        password: "123456",
        nickname: "test123",
        email: "test@example.com",
        age: 20
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic YmFuYW5h0m5hbmljYTEyMw==")

      {:ok, conn: conn, account_id: account_id}
    end

    test "When all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{ "value" => "50.00" }

      response =
        conn
          |> post(Routes.accounts_path(conn, :deposit, account_id, params))
          |> json_response(:ok)

      assert %{
        "account" => %{"balance" => "50.00", "id" => _id},
        "message" => "Ballance changed successfully"
      } = response

    end

    test "When there are invalids params, return an error", %{conn: conn, account_id: account_id} do
      params = %{ "value" => "banana" }

      response =
        conn
          |> post(Routes.accounts_path(conn, :deposit, account_id, params))
          |> json_response(:bad_request)

      expected_responde = %{"message" => "Invalid deposit value!"}

      assert expected_responde == response

    end
  end
end
