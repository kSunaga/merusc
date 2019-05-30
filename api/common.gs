function setUrl() {
  return SpreadsheetApp.getActiveSpreadsheet().getUrl()
}

function concatArray(array) {
  return Array.prototype.concat.apply([], array)
}

function dateFormatter(date, sig) {
  if(sig === '/') {
    return date.getFullYear + '/' + date.getMonth + '/' + date.getDay
  }else if(sig === 'M') {
    return date.getFullYear + '年'　+ date.getMonth + '月' + date.getDay + '日'
  }
}

function getNotEmptyValues(values) {
  var notEmptyValues = []
  for each(var value in values) {
    if(value != "") {
      notEmptyValues.push(value)
    }
  }
  return concatArray(notEmptyValues)
}
