# Description:
#   About X https://github.com/tylerlong/glip-hubot-x
#
# Commands:
#   hubot about - about X https://github.com/tylerlong/glip-hubot-x

module.exports = (robot) ->
  robot.respond /about$/i, (res) ->
    res.send """I'm [X](https://github.com/tylerlong/glip-hubot-x), a Glip bot for RingCentral Xiamen.
I'm created and maintained by [Tyler Long](https://github.com/tylerlong).
I'm built upon [Hubot](https://hubot.github.com/) with the [Glip Adapter](https://github.com/tylerlong/hubot-glip)."""
