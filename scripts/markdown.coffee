module.exports = (robot) ->
  robot.respond /markdown$/i, (res) ->
    spawn = require('child_process').spawnSync
    spawn('phantomjs', ['preview_markdown.js'])
    res.send "markdown test"
