# Description:
#   Currency conversion.
#
# Commands:
#   hubot money USD CNY - Convert 1 USD to CNY
request = require('request')

module.exports = (robot) ->
  robot.respond /money\s+([A-Z]{3})\s+([A-Z]{3})\s*$/, (res) ->
    request('http://finance.yahoo.com/d/quotes.csv?e=.csv&f=sl1d1t1&s=USDCNY=X', (error, response, body) ->
      if error
        res.send error
      else
        res.send "1 #{res.match[1]} = #{body.split(',')[1]} #{res.match[2]}"
    )
