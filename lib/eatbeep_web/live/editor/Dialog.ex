# From http://surface-demo.msaraiva.io/state_management
defmodule EatbeepWeb.Menu.Dialog do
  use Surface.LiveComponent
  alias Surface.Constructs.If

  prop title, :string, required: true

  data show, :boolean, default: false

  def render(assigns) do
    ~H"""
    <div id="dialog" >
    <If condition={{ @show }}>
    <div class="dialog"
    phx-capture-click="hide"
    phx-window-keydown="hide"
    phx-key="escape"
    phx-target={{ @myself }}>
      <div class="dialog-content">
        <header class="dialog-header">
          <p class="modal-card-title">{{ @title }}</p>
        </header>
        <section class="dialog-body">
          <slot/>
        </section>
      </div>
    </div>
    </If>
    </div>
    """
  end

  # Public API

  def show(dialog_id) do
    send_update(__MODULE__, id: dialog_id, show: true)
  end

  def hide(dialog_id) do
    send_update(__MODULE__, id: dialog_id, show: false)
  end

  # Event handlers

  def handle_event("show", _, socket) do
    {:noreply, assign(socket, show: true)}
  end

  def handle_event("hide", _, socket) do
    {:noreply, assign(socket, show: false)}
  end
end
