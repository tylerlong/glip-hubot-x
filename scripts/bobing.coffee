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
