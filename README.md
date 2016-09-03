# X (厦)

X (厦) is a [Glip](https://glip.com/) [bot](https://hubot.github.com/docs/) for [RingCentral Xmen](http://www.ringcentral.cn/).


## Run X locally

You can start X locally by running:

    ./bin/hubot -a shell -n x

Then you can talk to X via terminal:

```
x> x help
x> Shell: x help - Displays all of the help commands that Hubot knows about.
x help <query> - Displays all help commands that match <query>.
x list jobs - List current cron jobs
x map me <query> - Returns a map view of the area returned by `query`.
x new job "<crontab format>" <message> - Schedule a cron job to say something
x new job <crontab format> "<message>" - Ditto
x new job <crontab format> say <message> - Ditto
x remove job <id> - remove job
x remove job with message <message> - remove with message
x repeat "<str>" <n> times - Repeat <str> <n> times
x stock <ticker> - Get a stock price
x stock chart <ticker> [1d|5d|2w|1mon|1y] - Get a stock price and chart
```
