defmodule Term.ReaderTest do
  use ExUnit.Case, async: true
  doctest Term.Reader

  @read_message "Whts up?"
  @user_input "some choice"

  use Term.Reader

  defp gets(message) do
    assert @read_message == message
    @user_input <> "\n"
  end

  test "read text" do
    assert read(@read_message) == @user_input
  end
end
  