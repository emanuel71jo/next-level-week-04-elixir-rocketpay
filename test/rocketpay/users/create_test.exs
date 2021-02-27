defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.Users.Create
  alias Rocketpay.User

  describe "call/1" do
    test "When all params are valid, returns an user" do
      params = %{
        name: "Test",
        password: "123456",
        nickname: "teste123",
        email: "teste@test.com",
        age: 27
      }

      {:ok, %User{id: user_id}} = Create.call(params)

      user = Repo.get(User, user_id)

      assert %User{name: "Test", age: 27, id: ^user_id} = user
    end
  end

  describe "call/1" do
    test "When there are params invalid, returns an error" do
      params = %{
        name: "Test",
        password: "123456",
        nickname: "teste123",
        email: "teste1@test.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_responde = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert expected_responde == errors_on(changeset)
    end
  end
end
