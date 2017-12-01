# Description:
#   Register cron jobs to schedule messages on the current channel
#
# Commands:
#   hubot cron add <crontab format> say <message> - Schedule a cron job to say something
#   hubot cron ls - List cron jobs
#   hubot cron rm <id> - Remove a cron job
#
# Author:
#   Tyler Long

cronJob = require('cron').CronJob
moment = require('moment-timezone')
CronConverter = require('cron-converter')

JOBS = {}
cronConverter = new CronConverter({
  outputMonthNames: true,
  outputWeekdayNames: true,
})

createNewJob = (robot, pattern, user, message) ->
  id = Math.floor(Math.random() * 100000) while !id? || JOBS[id]
  job = registerNewJob robot, id, pattern, user, message
  robot.brain.data.cronjob[id] = job.serialize()
  id

storeJobToBrain = (robot, id, job) ->
  robot.brain.data.cronjob[id] = job.serialize()
  envelope = user: job.user, room: job.user.room
  robot.send envelope, "Job #{id} stored in brain asynchronously"

registerNewJob = (robot, id, pattern, user, message, timezone) ->
  job = new Job(id, pattern, user, message, timezone)
  job.timezone = 'Asia/Shanghai'
  job.start(robot)
  JOBS[id] = job

unregisterJob = (robot, id)->
  if JOBS[id]
    JOBS[id].stop()
    delete robot.brain.data.cronjob[id]
    delete JOBS[id]
    return yes
  no

handleNewJob = (robot, msg, pattern, message) ->
  try
    id = createNewJob robot, pattern, msg.message.user, message
    msg.send "Job #{id} created"
  catch error
    msg.send "Error caught parsing crontab pattern: #{error}. See http://crontab.org/ for the syntax"

syncJobs = (robot) ->
  nonCachedJobs = difference(robot.brain.data.cronjob, JOBS)
  for own id, job of nonCachedJobs
    registerNewJob robot, id, job...

  nonStoredJobs = difference(JOBS, robot.brain.data.cronjob)
  for own id, job of nonStoredJobs
    storeJobToBrain robot, id, job

difference = (obj1, obj2) ->
  diff = {}
  for id, job of obj1
    diff[id] = job if id !of obj2
  return diff

module.exports = (robot) ->
  robot.brain.data.cronjob or= {}
  robot.brain.on 'loaded', =>
    syncJobs robot

  robot.respond /time$/i, (msg) ->
    msg.send "Server time is: #{moment().tz("Asia/Shanghai").format()} (Asia/Shanghai timezone)"

  robot.respond /cron (?:add|new) (.+?) say ([\s\S]+?)$/i, (msg) ->
    try
      pattern = cronConverter.fromString(msg.match[1]).toString()
      handleNewJob robot, msg, pattern, msg.match[2]
    catch error
      msg.send "Crontab pattern invalid: #{error}"

  robot.respond /cron (?:ls|list)$/i, (msg) ->
    text = ''
    for id, job of JOBS
      room = job.user.reply_to || job.user.room
      if room == msg.message.user.reply_to or room == msg.message.user.room
        text += "#{id}: #{job.pattern} - #{job.message}\n"
    text = 'None' if text.length == 0
    msg.send text

  robot.respond /cron (?:rm|remove|del|delete) (\d+)$/i, (msg) ->
    if (id = msg.match[1]) and unregisterJob(robot, id)
      msg.send "Job #{id} deleted"
    else
      msg.send "Job #{id} does not exist"


class Job
  constructor: (id, pattern, user, message, timezone) ->
    @id = id
    @pattern = pattern
    @user = user
    @message = message
    @timezone = timezone

  start: (robot) ->
    @cronjob = new cronJob(@pattern, =>
      @sendMessage robot
    , null, false, @timezone)
    @cronjob.start()

  stop: ->
    @cronjob.stop()

  serialize: ->
    [@pattern, @user, @message, @timezone]

  sendMessage: (robot) ->
    envelope = user: @user, room: @user.room
    robot.send envelope, @message
