count = 0

module.exports = (robot) ->
  robot.hear /^(```[\s\S]+^```)$/m, (res) ->
    spawn = require('child_process').spawnSync
    code = res.match[1]
    spawn('phantomjs', ['preview_markdown.js', code, count])
    res.send "test_#{count}.png"
    count += 1
    if count == 100
      count = 0
