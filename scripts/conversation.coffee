class Conversation
  constructor: ->
    @options = []
    @timer = null
  reset: -> # reset timer and options
    clearTimeout(@timer)
    @options = []
  startTimer: -> # clear the conversation after 30 seconds
    setTimeout((() -> @options = []), 30000)
  addOption: (regex, res, callback) -> # add an conversation option
    @options.push [regex, res, callback]
  execute: (content) -> # execute based on user input
    for option in @options
      [regex, res, callback] = option
      match = content.match regex
      if match != null # if matches the option
        callback(res, match)
        @reset()
        break

conversation = new Conversation()


module.exports = (robot) ->
  robot.hear /jump$/i, (res) ->
    res.send 'how many times?'
    conversation.reset() # reset existing conversation
    conversation.addOption(/^(\d+)$/, res, (res, match) ->
      for i in [0...match[1]]
        res.send 'jump'
    )
    conversation.startTimer() # conversation expires in 30 seconds

  robot.hear /hungry$/i, (res) ->
    res.send 'What do you want to eat, bread or meat?'
    conversation.reset() # reset existing conversation
    conversation.addOption(/^bread$/i, res, (res, match) ->
      res.send 'Oh, I like bread too.'
    )
    conversation.addOption(/^meat$/i, res, (res, match) ->
      res.send "Oh, sorry meat has been sold out."
    )
    conversation.startTimer() # conversation expires in 30 seconds

  robot.hear /^([\s\S]+?)$/i, (res) ->
    conversation.execute res.match[1]
