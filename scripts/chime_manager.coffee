# Description:
#   チャイムを制御します
#
# Notes:
#

request = require('request')
fs = require('fs')

gooApiId = fs.readFileSync 'gooAPIkey.txt', 'utf8'

settingFile = "./chime_ignore.txt"

toLocaleDateString = (date) ->
  "#{do date.getFullYear}年#{do date.getMonth + 1}月#{do date.getDate}日"

module.exports = (robot) ->
  robot.hear /(.*)(鳴らす|ならす|鳴らし|ならし).*/i, (msg) ->
    options = {
      uri: "https://labs.goo.ne.jp/api/chrono",
      headers: { "Content-type": "application/json" },
      json: {
        "app_id": gooApiId,
        "sentence": msg.match[1]
      }
    }

    request.post options, (error, response, body) ->
      targetDate = new Date (do body.datetime_list.toString).split(",")[1]
      targetDateString = toLocaleDateString targetDate

      fs.readFile settingFile, 'utf8', (err, text) ->
        if text
          ignoreList = text.split('\n')
        else
          ignoreList = []

        if body.datetime_list.length != 0
          if ignoreList.indexOf(do targetDate.toDateString) != -1
            ignoreList.pop ignoreList.indexOf(do targetDate.toDateString)
            fs.writeFile settingFile, ignoreList.join('\n'), (err) ->
              if err
                msg.send err
              else
                msg.send "#{targetDateString} のチャイムを設定しました"
          else
            msg.send "#{targetDateString} のチャイムは既に設定されています"
        else
          msg.send "日付情報が取得できません"

  robot.hear /(.*)(鳴らさない|ならさない|止め|とめ).*/i, (msg) ->
    options = {
      uri: "https://labs.goo.ne.jp/api/chrono",
      headers: { "Content-type": "application/json" },
      json: {
        "app_id": gooApiId,
        "sentence": msg.match[1]
      }
    }

    request.post options, (error, response, body) ->
      targetDate = new Date (do body.datetime_list.toString).split(",")[1]
      targetDateString = toLocaleDateString targetDate

      fs.readFile settingFile, 'utf8', (err, text) ->
        if text
          ignoreList = text.split('\n')
        else
          ignoreList = []

        if body.datetime_list.length != 0
          if ignoreList.indexOf(do targetDate.toDateString) == -1
            ignoreList.push (do targetDate.toDateString)
            fs.writeFile settingFile, ignoreList.join('\n'), (err) ->
              if err
                msg.send err
              else
                msg.send "#{targetDateString} のチャイムを解除しました"
          else
            msg.send "#{targetDateString} のチャイムは既に解除されています"
        else
          msg.send "日付情報が取得できません"
