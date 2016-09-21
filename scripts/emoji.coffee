# Description:
#   show emojis http://emojione.com/demo/
#
# Commands:
#   hubot emoji <dog> <cat> ... - show emojis. http://emojione.com/demo/

emojione = require('emojione')
emojione.cacheBustParam = ''

module.exports = (robot) ->
  robot.respond /emoji((?:\s+[0-9a-z_]+)+)\s*$/i, (res) ->
    emojis = res.match[1].trim().split(/\s+/)
    for emoji in emojis
      image = emojione.shortnameToImage(":#{emoji}:")
      if ":#{emoji}:" == image
        res.send "no emoji for \"#{emoji}\""
        return
      code = image.match(/\/assets\/png\/([a-f0-9-]+)\.png/)[1]
      url = "https://cdn.rawgit.com/Ranks/emojione/master/assets/png_128x128/#{code}.png"
      envelope = { user: res.message.user, message_type: 'image_url' }
      robot.send envelope, url
