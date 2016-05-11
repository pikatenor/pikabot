# Description:
#   チャイムを鳴らします
#
# Notes:
#   cronモジュール使います
#   

cron = require('cron').CronJob

module.exports = (robot) ->

# 水曜日
  new cron '00 15 12 * * 3', () =>
    robot.send {room: "#chime"}, "授業始まるぞ！！！"
  , null, true, "Asia/Tokyo"

  new cron '00 30 13 * * 3', () =>
    robot.send {room: "#chime"}, "休憩だぞ！！！"
  , null, true, "Asia/Tokyo"

  new cron '00 45 13 * * 3', () =>
    robot.send {room: "#chime"}, "休憩終わりだぞ！！！"
  , null, true, "Asia/Tokyo"

  new cron '00 00 15 * * 3', () =>
    robot.send {room: "#chime"}, "授業終わりだぞ！！！"
  , null, true, "Asia/Tokyo"

# 金曜日
  new cron '00 15 15 * * 5', () =>
    robot.send {room: "#chime"}, "授業始まるぞ！！！"
  , null, true, "Asia/Tokyo"

  new cron '00 30 16 * * 5', () =>
    robot.send {room: "#chime"}, "休憩だぞ！！！"
  , null, true, "Asia/Tokyo"

  new cron '00 45 16 * * 5', () =>
    robot.send {room: "#chime"}, "休憩終わりだぞ！！！"
  , null, true, "Asia/Tokyo"

  new cron '00 00 18 * * 5', () =>
    robot.send {room: "#chime"}, "授業終わりだぞ！！！"
  , null, true, "Asia/Tokyo"
  
