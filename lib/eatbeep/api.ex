defmodule Eatbeep.Api do
  use Ash.Api

  resources do
    resource Eatbeep.User
    resource Eatbeep.Tenant
    resource Eatbeep.Role
    resource Eatbeep.Menu
  end
end
