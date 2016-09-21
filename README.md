# X

X is a [Glip](https://glip.com/) [bot](https://hubot.github.com/docs/) for [RingCentral Xiamen](http://www.ringcentral.cn/).


## Run X locally

You can start X locally by running:

    ./bin/hubot -a shell -n x

Then you can talk to X via terminal:

```
x> x help
x> Shell: x help - Displays all of the help commands that Hubot knows about.
x cron add <crontab format> say <message> - Schedule a cron job to say something
x cron ls - List cron jobs
x cron rm <id> - remove a cron job
x help - Displays all of the help commands that Hubot knows about.
x help <query> - Displays all help commands that match <query>.
x map me <query> - Returns a map view of the area returned by `query`.
x repeat "<str>" <n> times - Repeat <str> <n> times
x stock <ticker> - Get a stock price
x stock chart <ticker> [1d|5d|2w|1mon|1y] - Get a stock price and chart
```


## todo

- if one-one chat, print help if don't understand user's input. Just like the terminal.
- support fenced code block
