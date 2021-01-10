defmodule EatbeepWeb.Menu.QRCode do
  use Surface.Component

  prop tenant_id, :integer

  def render(assigns) do
    code = Eatbeep.QR.generate_code(assigns.tenant_id)

    ~H"""
    <div>{{ raw(code) }}</div>
    """
  end
end
