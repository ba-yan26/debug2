process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      Popper: 'popper.js'
    })
  )

module.exports = environment.toWebpackConfig()
