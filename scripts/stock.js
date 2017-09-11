// Commands:
//   hubot stock <ticker> - Get a stock price
const request = require('request')
const R = require('ramda')

module.exports = robot => {
  robot.respond(/stock (.+?)$/, res => {
    const symbol = res.match[1].toUpperCase()
    request(`https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22${symbol}%22)&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys`, (error, response, body) => {
      if (error !== null) {
        res.send(`Failed to fetch quote for ${symbol}`)
        return
      }
      const json = JSON.parse(body)
      let quote = json.query.results.quote
      quote = R.pick(['symbol', 'Change', 'PercentChange', 'LastTradeDate', 'DaysRange', 'LastTradePriceOnly'], quote)
      quote.LastTradePrice = quote.LastTradePriceOnly
      delete quote.LastTradePriceOnly
      res.send(JSON.stringify(quote, null, 4))
    })
  })
}

/*
{
    "symbol": "RNG",
    "Ask": "64.55",
    "AverageDailyVolume": "716983",
    "Bid": "40.15",
    "AskRealtime": null,
    "BidRealtime": null,
    "BookValue": "2.01",
    "Change_PercentChange": "-0.30 - -0.70%",
    "Change": "-0.30",
    "Commission": null,
    "Currency": "USD",
    "ChangeRealtime": null,
    "AfterHoursChangeRealtime": null,
    "DividendShare": null,
    "LastTradeDate": "9/8/2017",
    "TradeDate": null,
    "EarningsShare": "-0.39",
    "ErrorIndicationreturnedforsymbolchangedinvalid": null,
    "EPSEstimateCurrentYear": "0.17",
    "EPSEstimateNextYear": "0.30",
    "EPSEstimateNextQuarter": "0.06",
    "DaysLow": "42.05",
    "DaysHigh": "42.85",
    "YearLow": "19.35",
    "YearHigh": "43.05",
    "HoldingsGainPercent": null,
    "AnnualizedGain": null,
    "HoldingsGain": null,
    "HoldingsGainPercentRealtime": null,
    "HoldingsGainRealtime": null,
    "MoreInfo": null,
    "OrderBookRealtime": null,
    "MarketCapitalization": "3.25B",
    "MarketCapRealtime": null,
    "EBITDA": "-12.96M",
    "ChangeFromYearLow": "23.00",
    "PercentChangeFromYearLow": "+118.86%",
    "LastTradeRealtimeWithTime": null,
    "ChangePercentRealtime": null,
    "ChangeFromYearHigh": "-0.70",
    "PercebtChangeFromYearHigh": "-1.63%",
    "LastTradeWithTime": "3:59pm - <b>42.35</b>",
    "LastTradePriceOnly": "42.35",
    "HighLimit": null,
    "LowLimit": null,
    "DaysRange": "42.05 - 42.85",
    "DaysRangeRealtime": null,
    "FiftydayMovingAverage": "37.86",
    "TwoHundreddayMovingAverage": "33.25",
    "ChangeFromTwoHundreddayMovingAverage": "9.10",
    "PercentChangeFromTwoHundreddayMovingAverage": "+27.36%",
    "ChangeFromFiftydayMovingAverage": "4.49",
    "PercentChangeFromFiftydayMovingAverage": "+11.85%",
    "Name": "Ringcentral, Inc. Class A",
    "Notes": null,
    "Open": "42.50",
    "PreviousClose": "42.65",
    "PricePaid": null,
    "ChangeinPercent": "-0.70%",
    "PriceSales": "7.56",
    "PriceBook": "21.26",
    "ExDividendDate": null,
    "PERatio": null,
    "DividendPayDate": null,
    "PERatioRealtime": null,
    "PEGRatio": "4.17",
    "PriceEPSEstimateCurrentYear": "249.12",
    "PriceEPSEstimateNextYear": "141.17",
    "Symbol": "RNG",
    "SharesOwned": null,
    "ShortRatio": "2.98",
    "LastTradeTime": "3:59pm",
    "TickerTrend": null,
    "OneyrTargetPrice": "42.00",
    "Volume": "647863",
    "HoldingsValue": null,
    "HoldingsValueRealtime": null,
    "YearRange": "19.35 - 43.05",
    "DaysValueChange": null,
    "DaysValueChangeRealtime": null,
    "StockExchange": "NYQ",
    "DividendYield": null,
    "PercentChange": "-0.70%"
}
*/
