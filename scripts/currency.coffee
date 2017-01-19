# Description:
#   Currency conversion.
#
# Commands:
#   hubot money USD CNY - Convert 1 USD to CNY
request = require('request')

module.exports = (robot) ->
  robot.respond /money\s+([A-Z]{3})\s+([A-Z]{3})\s*$/i, (res) ->
    source = res.match[1].toUpperCase()
    target = res.match[2].toUpperCase()
    request("http://finance.yahoo.com/d/quotes.csv?e=.csv&f=sl1d1t1&s=#{source}#{target}=X", (error, response, body) ->
      if error
        res.send error
      else
        res.send "1 #{source} = #{body.split(',')[1]} #{target}"
    )
