# Configuration:
#   HUBOT_blacklist
#   HUBOT_blacklist_PATH

reach = require('hoek').reach
path = require('path')

module.exports = (robot) ->

  # Establish blacklist
  blacklist = []
  if process.env.HUBOT_BLACKLIST
    blacklist = process.env.HUBOT_BLACKLIST.split(',')
  else if process.env.HUBOT_BLACKLIST_PATH
    blacklist = require(path.resolve(process.env.HUBOT_BLACKLIST_PATH))

  unless Array.isArray(blacklist)
    robot.logger.error 'blacklist is not an array!'

  robot.receiveMiddleware (context, next, done) ->
    # if the room is in the blacklist
    if reach(context, 'response.envelope.room') in blacklist
      next(done)
    else
      # We're done
      context.response.message.finish()
      done()
