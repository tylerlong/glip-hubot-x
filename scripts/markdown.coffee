spawn = require('child_process').spawnSync


count = 0
module.exports = (robot) ->
  robot.hear /^\s*(```[\s\S]+^\s*```)\s*$/m, (res) ->
    code = res.match[1]
    spawn('phantomjs', ['preview_markdown.js', code, count])
    url = "#{process.env.GLIP_X_HOST}/md_#{count}.png"
    res.send url

    count += 1
    if count == 1000
      count = 0
