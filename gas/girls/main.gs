'use strict'

function doGet(e = {}) {
  const action = (e.parameter && e.parameter.action) || 'aliases'

  switch (action) {
    case 'girls':
      return girlsResponse()
    default:
      return aliasesResponse()
  }
}

function jsonOutput(data) {
  return ContentService.createTextOutput(JSON.stringify(data)).setMimeType(ContentService.MimeType.JSON)
}

function getRows() {
  const sheet = SpreadsheetApp.getActiveSpreadsheet()
  const rows = sheet.getDataRange().getValues()
  const keys = rows.splice(0, 1)[0]
  return rows.map(row => {
    const record = {}
    row.map((val, i) => {record[keys[i]] = val})
    return record
  }).filter(record => record.key != '')
}

function formatDate(val) {
  if (!val || !(val instanceof Date)) return null
  return (val.getMonth() + 1) + '/' + val.getDate()
}

function girlsResponse() {
  const records = getRows()
  const output = records.map(record => {
    const girl = {
      key: record.key,
      cure_name: record.cure_name,
      human_name: record.human_name,
      cv: record.cv,
      nickname: record.nickname ? record.nickname.split(',') : [],
      birthday: formatDate(record.birthday),
      cv_birthday: formatDate(record.cv_birthday),
      title: record.title,
    }
    return girl
  })
  return jsonOutput(output)
}

function aliasesResponse() {
  const records = getRows()
  const output = {}

  records.map(record => {
    if (record.human_name != '') {
      output[record.cure_name] = [record.human_name]
      output[record.human_name] = [record.cure_name]
    }

    if (record.cv != '') {
      output[record.cure_name].push(record.cv)
      output[record.human_name].push(record.cv)
      output[record.cv] = []
    }

    if (record.nickname != '') {
      record.nickname.split(',').map(nickname => {
        output[nickname] = [record.cure_name, record.human_name]
        if (record.cv) {output[nickname].push(record.cv)}
      })
    }
    if (record.nickname_unofficial != '') {
      record.nickname_unofficial.split(',').map(nickname => {
        output[nickname] = [record.cure_name, record.human_name]
        if (record.cv) {output[nickname].push(record.cv)}
      })
    }
  })

  return jsonOutput(output)
}
