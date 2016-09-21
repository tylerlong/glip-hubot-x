express = require 'express'


module.exports = (robot) ->
  robot.router.use(express.static('static'))
