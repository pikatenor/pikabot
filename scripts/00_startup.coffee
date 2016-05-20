# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

exec = require('child_process').exec

module.exports = (robot) ->

  exec 'git describe --always --tags', (err, stdout, stderr) ->

    ver = ""

    if err
      robot.logger.error "error while getting an version infomation."

    if stdout
      ver = stdout.trim() + " "

    robot.send {room: '#pikabot-dev'}, "pikabot #{ver}is running."



