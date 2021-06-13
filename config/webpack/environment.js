const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

// https://www.driftingruby.com/episodes/organizing-stimulus-controllers
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  ApplicationController: ['application_controller', 'default'],
  $: "jquery",
  jQuery: "jquery",
  jquery: "jquery",
  "window.jQuery": "jquery",
  Popper: ["popper.js", "default"]
}))

module.exports = environment
