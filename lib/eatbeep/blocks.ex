defmodule Eatbeep.Blocks do
  use Ecto.Schema
  import Ecto.Changeset

  def hero_changeset(attrs \\ %{}) do
    data = %{}
    types = %{name: :string, bid: :string, __type: :string, background: :string}

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

  def generate_starting_data() do
    [%{__type: "hero", bid: Ecto.UUID.generate(), name: "Acme Pizza", background: "h0Vxgz5tyXA"},
    %{__type: "heading", bid: Ecto.UUID.generate(), heading: "Starters"},
    %{__type: "product", bid: Ecto.UUID.generate(), name: "Bruschetta", description: "Sun blushed tomatoes, with basil, garlic and olive oil on our homemade bread"},
    %{__type: "product", bid: Ecto.UUID.generate(), name: "Calamari Fritti", description: "Deep fried squid in a light and crispy batter"},
    %{__type: "heading", bid: Ecto.UUID.generate(), heading: "Mains"},
    %{__type: "product", bid: Ecto.UUID.generate(), name: "Calzone Pollo", description: "Folded pizza with chicken breast pieces, button mushrooms and black olives, served with our tomato sauce"},
    %{__type: "product", bid: Ecto.UUID.generate(), name: "Margherita", description: "Our tomato sauce and mozzarella. Gluten free base available"},
    %{__type: "product", bid: Ecto.UUID.generate(), name: "Quattro Stagioni", description: "Spicy Italian salami, honey roasted ham, button mushrooms and black olives"},
    %{__type: "heading", bid: Ecto.UUID.generate(), heading: "Desserts"},
    %{__type: "product", bid: Ecto.UUID.generate(), name: "Tiramisu", description: "Our very own homemade Tiramisu, lovingly prepared with Savoiardi biscuits soaked in espresso coffee, doused with liquer and topped with mascarpone cream"},
    %{__type: "product", bid: Ecto.UUID.generate(), name: "Profiteroles", description: "Cream filled choux pastry puffs coated in thick chocolate fondant"},
    %{__type: "product", bid: Ecto.UUID.generate(), name: "Affogato", description: "Two scoops of Italian ice cream of your choice drowned in espresso coffee"}
  ]
  end

end
