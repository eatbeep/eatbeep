Ash.Changeset.new(Eatbeep.User, %{name: "ben"})

Ash.Changeset.new(Eatbeep.User, %{name: "ben", email: "ben@example.com"}) |> Ash.Changeset.set_argument(:password, "password") |>  Eatbeep.Api.create(action: :set_password)

Eatbeep.Api.create(x)

Eatbeep.Api.get(Eatbeep.User, [email: "ben@example.com"])

Eatbeep.User.random_id()


Ash.Changeset.new(Eatbeep.User, %{name: "ben"}) |> Eatbeep.Api.create()

Ash.Changeset.new(Eatbeep.Tenant, %{name: "bravo"}) |> Eatbeep.Api.create()

Eatbeep.Api.get!(Eatbeep.Tenant, "exeecrqy") |> Ash.Changeset.new() |> Ash.Changeset.replace_relationship(:users, [{"yzdgv8h3", %{role: "owner"}}]) |> Eatbeep.Api.update!()

// It's idempotent! Automatically using the on conflict - clever

Eatbeep.Api.get!(Eatbeep.Tenant, "exeecrqy") |> Ash.Changeset.new() |> Ash.Changeset.append_to_relationship(:users, [{"yzdgv8h3", %{role: "readonly"}}]) |> Eatbeep.Api.update!()


append_to_relationship


one user

two tenants

authorization...

test multi tenancy on menus, should products be as well? blocks?

transactional insert for new signup
yes, probably need two changesets?

Ash.Changeset.new(Eatbeep.Menu, %{name: "default"}) |> Ash.Changeset.replace_relationship(:tenant, "exeecrqy") |> Eatbeep.Api.create()

%{
  user_id: "1",
  tenant_id: "123",
  role: "foo"
}

Eatbeep.Api.get!(Eatbeep.Menu, "p5ydv7qn", actor: %{user_id: "1", tenant_id: "123", role: "super_admin"}, authorize?: true)

need to figure out how to check actor attribute and changeset


this works:
Eatbeep.Menu |> Ash.Query.set_tenant("0iir65sy") |> Eatbeep.Api.read!()

Eatbeep.Menu |> Ash.Query.set_tenant("0iir65sy") |> Eatbeep.Api.read_one()



Eatbeep.Menu |> Eatbeep.Api.get!("p5ydv7qn") |> Changeset.new |> Eatbeep.Api.create()

Eatbeep.Api.load(:menus)



Ash.DataLayer.transact(Eatbeep.Tenant, fn -> 
  t = Eatbeep.Api.get!(Eatbeep.Tenant, "exeecrqy")
  Eatbeep.Api.get!(Eatbeep.Tenant, "exeecrqy")
  true
end)"

%{"tenant" => %{"name" => "Acme"}, "user" => %{"name" => "ben"}} |> Eatbeep.Signup.signup()

Eatbeep.Signup.signup(%{"tenant" => %{"name": "Acme"}, "user" => %{"email": "ben@example.com"}})

Ash.Changeset.new(Eatbeep.User, %{name: "ben"}) |> Ash.Changeset.set_argument(:password, nil) |> Eatbeep.Api.create!(action: :signup)


What are the rough edges?
More advanced query types
Integer IDs?

