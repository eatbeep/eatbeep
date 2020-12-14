defmodule Eatbeep.Login do

  def login(email, password) do
    case Eatbeep.Api.get!(Eatbeep.User, [email: email]) |> Bcrypt.check_pass(password, hash_key: :hashed_password) do
      {:ok, user} -> "token123"
      {:error, _} -> "Unable to login"
    end
  end


end
