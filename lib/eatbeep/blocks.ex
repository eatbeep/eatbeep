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

  def product_changeset(attrs \\ %{}) do
    data = %{}
    types = %{name: :string, description: :string, bid: :string, __type: :string}

      {data, types}
      |> cast(attrs, Map.keys(types))
      |> validate_required([:name, :bid, :__type, :description])
  end

  def new_block("heading") do
    heading_changeset(%{
      bid: Ecto.UUID.generate(),
      __type: "heading",
      heading: "Lorem Ipsum"
    }) |> Map.get(:changes)
  end

  def new_block("product") do
    product_changeset(%{
      bid: Ecto.UUID.generate(),
      __type: "product",
      name: "Pellentesque ac fermentum metus",
      description: "Vivamus scelerisque nunc ac fermentum euismod. Vestibulum accumsan volutpat lectus."
    }) |> Map.get(:changes)
  end

end
