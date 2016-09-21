# Description:
#   中秋博饼


getRandomInt = () =>
    Math.floor(Math.random() * 6) + 1

compare = (a, b) =>
  if a == 4
    return -1
  if b == 4
    return 1
  return a > b ? 1 : -1

title = (numbers) =>
  dict = { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0 }
  for i in numbers
    dict[i] += 1
  if dict[4] >= 4
    return '状元'
  for i in [1,2,3,5,6]
    if dict[i] >= 5
      return '状元'
  if dict[1] == 1 && dict[2] == 1 && dict[3] == 1 && dict[4] == 1 && dict[5] == 1 && dict[6] == 1
    return '榜眼 (对堂)'
  if dict[4] == 3
    return '探花 (三红)'
  for i in [1,2,3,5,6]
    if dict[i] == 4
      return '进士 (四进)'
  if dict[4] == 2
    return '举人 (二举)'
  if dict[4] == 1
    return '秀才 (一秀)'
  return '平民'

bobing = (res) ->
  numbers = [getRandomInt(), getRandomInt(), getRandomInt(), getRandomInt(), getRandomInt(), getRandomInt()]
  numbers.sort compare
  result = numbers.map((i) =>
    ":dice_#{i}:"
  ).join(' ')
  yourTitle = title(numbers)
  if yourTitle == '平民'
    result += "\n很遗憾您名落孙山！"
  else
    result += "\n恭喜您高中 #{yourTitle} ！"
  res.send result

module.exports = (robot) ->
  robot.respond /bb$/i, bobing

  robot.respond /bb rules$/i, (res) ->
    res.send """中秋博饼游戏规则
名称	说明
状元	四个红∷以上或者五个相同的其它数字以上
榜眼（对堂）	必须每个骰子都不同
探花（三红）	有三个骰子为红∷
进士（四进）	骰子有四个相同数字（除∷外）
举人（二举）	骰子摇中两个红∷即为举人
秀才（一秀）	有一个红∷"""

  # robot.hear /badger/i, (res) ->
  #   res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"
  #
  # robot.respond /open the (.*) doors/i, (res) ->
  #   doorType = res.match[1]
  #   if doorType is "pod bay"
  #     res.reply "I'm afraid I can't let you do that."
  #   else
  #     res.reply "Opening #{doorType} doors"
  #
  # robot.hear /I like pie/i, (res) ->
  #   res.emote "makes a freshly baked pie"
  #
  # lulz = ['lol', 'rofl', 'lmao']
  #
  # robot.respond /lulz/i, (res) ->
  #   res.send res.random lulz
  #
  # robot.topic (res) ->
  #   res.send "#{res.message.text}? That's a Paddlin'"
  #
  #
  # enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
  # leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  #
  # robot.enter (res) ->
  #   res.send res.random enterReplies
  # robot.leave (res) ->
  #   res.send res.random leaveReplies
  #
  # answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING
  #
  # robot.respond /what is the answer to the ultimate question of life/, (res) ->
  #   unless answer?
  #     res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
  #     return
  #   res.send "#{answer}, but what is the question?"
  #
  # robot.respond /you are a little slow/, (res) ->
  #   setTimeout () ->
  #     res.send "Who you calling 'slow'?"
  #   , 60 * 1000
  #
  # annoyIntervalId = null
  #
  # robot.respond /annoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #     return
  #
  #   res.send "Hey, want to hear the most annoying sound in the world?"
  #   annoyIntervalId = setInterval () ->
  #     res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
  #   , 1000
  #
  # robot.respond /unannoy me/, (res) ->
  #   if annoyIntervalId
  #     res.send "GUYS, GUYS, GUYS!"
  #     clearInterval(annoyIntervalId)
  #     annoyIntervalId = null
  #   else
  #     res.send "Not annoying you right now, am I?"
  #
  #
  # robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
  #   room   = req.params.room
  #   data   = JSON.parse req.body.payload
  #   secret = data.secret
  #
  #   robot.messageRoom room, "I have a secret: #{secret}"
  #
  #   res.send 'OK'
  #
  # robot.error (err, res) ->
  #   robot.logger.error "DOES NOT COMPUTE"
  #
  #   if res?
  #     res.reply "DOES NOT COMPUTE"
  #
  # robot.respond /have a soda/i, (res) ->
  #   # Get number of sodas had (coerced to a number).
  #   sodasHad = robot.brain.get('totalSodas') * 1 or 0
  #
  #   if sodasHad > 4
  #     res.reply "I'm too fizzy.."
  #
  #   else
  #     res.reply 'Sure!'
  #
  #     robot.brain.set 'totalSodas', sodasHad+1
  #
  # robot.respond /sleep it off/i, (res) ->
  #   robot.brain.set 'totalSodas', 0
  #   res.reply 'zzzzz'
