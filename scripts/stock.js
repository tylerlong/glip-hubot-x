// Commands:
//   hubot stock <ticker> - Get a stock price
const request = require('request')
const R = require('ramda')

module.exports = robot => {
  robot.respond(/stock (.+?)$/, res => {
    const symbol = res.match[1].toUpperCase()
    request(`https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22${symbol}%22)&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys`, (error, response, body) => {
      if(error !== null) {
        res.send(`Failed to fetch quote for ${symbol}`)
        return
      }
      const json = JSON.parse(body)
      let quote = json.query.results.quote
      // quote = R.pick([''], quote)
      res.send(JSON.stringify(quote, null, 4))
    })
  })
}
