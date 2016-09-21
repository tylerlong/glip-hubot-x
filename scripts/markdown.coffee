# Description:
#   Render markdown as image
#
# Commands:
#   [md]write markdown here, line breaks are allowed[/md]

spawn = require('child_process').spawnSync


count = 0
process_markdown = (robot, res) ->
  markdown = res.match[1]
  spawn('phantomjs', ['preview_markdown.js', markdown, count])
  url = "#{process.env.GLIP_X_HOST}/md_#{count}.png"
  envelope = { user: res.message.user, message_type: 'image_url' }
  robot.send envelope, url

  count += 1
  if count == 1000
    count = 0


module.exports = (robot) ->
  robot.hear /^\s*(```[\s\S]+^\s*```)\s*$/m, (res) ->
    process_markdown(robot, res)

  robot.hear /^\s*\[md\]([\s\S]+)\[/md\]\s*$/i, (res) ->
    process_markdown(robot, res)
