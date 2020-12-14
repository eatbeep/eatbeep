import "../css/app.css"
import "phoenix_html"
import {Socket} from "phoenix"
import NProgress from "nprogress"
import {LiveSocket} from "phoenix_live_view"
import Sortable from "sortablejs"

let hooks = {}

hooks.sortable = {
  mounted() {
    console.log('mounted ')
    Sortable.create(this.el, {
      handle: '.move-button',
      onEnd: (e) => {
        if (e.oldIndex != e.newIndex) {
          this.pushEvent("move_block", {
            old_index: e.oldIndex,
            new_index: e.newIndex
          })
        }
          // let old_pos = Evt.oldIndex + 1,
          //     new_pos = Evt.newIndex + 1;
          // if (old_pos != new_pos) {
          //     this.pushEvent('move_column', {
          //         old_pos: old_pos,
          //         new_pos: new_pos});
          // }
      }})
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {hooks, params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", info => NProgress.start())
window.addEventListener("phx:page-loading-stop", info => NProgress.done())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

