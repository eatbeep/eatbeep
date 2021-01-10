defmodule Eatbeep.Blocks do
  use Ecto.Schema
  import Ecto.Changeset

  def hero_changeset(attrs \\ %{}) do
    data = %{}
    types = %{name: :string, bid: :string, __type: :string}

      {data, types}
      |> cast(attrs, Map.keys(types))
      |> validate_required([:name, :bid, :__type])
  end

  def heading_changeset(attrs \\ %{}) do
    data = %{}
    types = %{heading: :string, bid: :string, __type: :string}

      {data, types}
      |> cast(attrs, Map.keys(types))
      |> validate_required([:heading, :bid, :__type])
  end

  def new_block("heading") do
    heading_changeset(%{
      bid: Ecto.UUID.generate(),
      __type: "heading",
      heading: "Lorem Ipsum"
    }) |> Map.get(:changes)
  end

end
