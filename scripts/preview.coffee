# Description:
#   Preview image links


urlExpression = /https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/gi
imgUrlExpression = /\.(?:png|jpg|jpeg|gif)$/i

module.exports = (robot) ->
  robot.hear urlExpression, (res) ->
    for url in res.match
      if url.match(imgUrlExpression) != null # image url found
        if !url.endsWith('#.png') # doesn't support http://chart.finance.yahoo.com/z?s=rng&t=1d&q=l&l=on&z=l&a=v&p=s&lang=en-US&region=US#.png
          envelope = { user: res.message.user, message_type: 'image_url' }
          robot.send envelope, url
