defmodule Rocketpay.NumbersTest do
  use ExUnit.Case

  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "when there is a file with the given number, returns the sum of numbers" do
      responde = Numebers.sum_from_file("numbers")

      expected_responde = {:ok, %{result: 37}}

      assert responde == expected_responde
    end
    test "when there no a file with the given number, returns an error" do
      responde = Numebers.sum_from_file("bananas")

      expected_responde = {:error, %{message: "Invalid file!"}}

      assert responde == expected_responde
    end
  end
end
