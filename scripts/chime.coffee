# Description:
#   チャイムを鳴らします
#
# Notes:
#   cronモジュール使います
#

cron = require('cron').CronJob
fs = require('fs')

settingFile = "./chime_ignore.txt"

chime = (message) ->
  fs.readFile settingFile, 'utf8', (err, text) ->
    if text
      ignoreList = text.split('\n')
    else
      ignoreList = []

    today = do (do new Date).toDateString
    if ignoreList.indexOf today == -1
      robot.send {room: "#chime"}, message

module.exports = (robot) ->

# 水曜日
  new cron '00 15 12 * * 3', () =>
    chime "授業始まるぞ！！！"
  , null, true, "Asia/Tokyo"

  new cron '00 30 13 * * 3', () =>
    chime "休憩だぞ！！！"
  , null, true, "Asia/Tokyo"

  new cron '00 45 13 * * 3', () =>
    chime "休憩終わりだぞ！！！"
  , null, true, "Asia/Tokyo"

  new cron '00 00 15 * * 3', () =>
    chime "授業終わりだぞ！！！"
  , null, true, "Asia/Tokyo"

# 金曜日
  new cron '00 15 15 * * 5', () =>
    chime "授業始まるぞ！！！"
  , null, true, "Asia/Tokyo"

  new cron '00 30 16 * * 5', () =>
    chime "休憩だぞ！！！"
  , null, true, "Asia/Tokyo"

  new cron '00 45 16 * * 5', () =>
    chime "休憩終わりだぞ！！！"
  , null, true, "Asia/Tokyo"

  new cron '00 00 18 * * 5', () =>
    chime "授業終わりだぞ！！！"
  , null, true, "Asia/Tokyo"
