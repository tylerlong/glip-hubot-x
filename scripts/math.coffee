# Description:
#   Do some math. http://mathjs.org/docs/expressions/syntax.html
#
# Commands:
#   hubot math <expression> - Evaluate the math expression. http://mathjs.org/docs/expressions/syntax.html

math = require('mathjs');

module.exports = (robot) ->
  robot.respond /math (.+?)$/i, (res) ->
    try
      res.send "#{res.match[1]} = #{math.eval res.match[1]}"
    catch error
      res.send "#{error}. See http://mathjs.org/docs/expressions/syntax.html for the documentation."
