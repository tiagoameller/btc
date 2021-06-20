import { Controller} from "stimulus"
import consumer from '../channels/consumer'
import ChartsController from "controllers/charts_controller"

export default class extends Controller {
  connect() {
    window.App.chartsController = new ChartsController()
  }

  initialize() {
    this.subscription()
  }

  disconnect() {
    this.subscription().unsubscribe()
    this.subscription().disconnected()
  }

  subscription() {
    if (this._subscription == undefined) {
      let _this = this
      this._subscription = consumer.subscriptions.create(
        { channel: "BackgroundUpdateChannel", id: 1 },
        {
        connected() {
          // Called when the subscription is ready for use on the server
        },

        disconnected() {
          // Called when the subscription has been terminated by the server
        },

        received(data) {
          // Called when there's incoming data on the websocket for this channel
          window.App.chartsController.fetchSelectedGraph()
        }
      })
    }
    return this._subscription
  }
}