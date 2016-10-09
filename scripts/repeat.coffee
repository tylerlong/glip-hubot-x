# Description:
#   Script to repeat a string several times.
#
# Commands:
#   hubot repeat <str> <n> times - Repeat <str> <n> times
#   hubot resend <str> <n> times - Resend <str> <n> times

module.exports = (robot) ->
  robot.respond /repeat ([\s\S]+?) (\d+) times$/i, (res) ->
    res.send res.match[1].repeat(res.match[2])

  robot.respond /resend ([\s\S]+?) (\d+) times$/i, (res) ->
    for i in [0...res.match[2]]
      res.send res.match[1].replace('<n>', i + 1)
