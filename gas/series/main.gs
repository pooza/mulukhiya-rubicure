'use strict'

function doGet(e = {}) {
  const action = (e.parameter && e.parameter.action) || 'aliases'

  switch (action) {
    case 'series':
      return seriesResponse()
    default:
      return aliasesResponse()
  }
}

function jsonOutput(data) {
  return ContentService.createTextOutput(JSON.stringify(data)).setMimeType(ContentService.MimeType.JSON)
}

function getSheetRows() {
  const sheet = SpreadsheetApp.getActiveSpreadsheet()
  const rows = sheet.getDataRange().getValues()
  const keys = rows.splice(0, 1)[0]
  return rows.map(row => {
    const item = {}
    row.map((val, i) => {
      item[keys[i]] = val
    })
    return item
  }).filter(item => item.key != '')
}

function seriesResponse() {
  const records = getSheetRows()
  const output = records.map(record => {
    return {
      key: record.key,
      series: record.series,
    }
  })
  return jsonOutput(output)
}

function aliasesResponse() {
  const records = getSheetRows()
  const output = {}
  records.map(item => {
    output[item.series] = []
    if (item.related_series) {
      output[item.series] = item.related_series.split(',')
    }
    if (item.nicknames) {
      item.nicknames.split(',').map(nickname => {
        output[nickname] = [item.series]
      })
    }
  })
  return jsonOutput(output)
}
