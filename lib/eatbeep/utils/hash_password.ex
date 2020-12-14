
defmodule Eatbeep.HashPassword do
  use Ash.Resource.Change

  def hash_password() do
    {__MODULE__, []}
  end

  def init(opts), do: {:ok, opts}

  def change(changeset, _opts, _context) do
    password = changeset.arguments.password
    # if (password == nil) - validate myself?
    hashed = Bcrypt.hash_pwd_salt(password)

    Ash.Changeset.change_attribute(changeset, :hashed_password, hashed)
  end
end
