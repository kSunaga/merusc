var searchSS = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("search")
var keywordValues = getNotEmptyValues(searchSS.getRange('A2:A').getValues())
var minValues = getNotEmptyValues(searchSS.getRange('B2:B').getValues())
var maxValues = getNotEmptyValues(searchSS.getRange('C2:C').getValues())


function doGet(e) {
    var response = getResponse()
    var responseText;
    var out = ContentService.createTextOutput();
    var callback = e.parameter.callback;

    if (callback) {
        responseText = callback + "(" + JSON.stringify(response) + ")";
        out.setMimeType(ContentService.MimeType.JAVASCRIPT);

    } else {
        responseText = JSON.stringify(response);
        out.setMimeType(ContentService.MimeType.JSON);
    }
    out.setContent(responseText);

    return out;
}

function getResponse() {
  return makeKeywordResponse()
}

function makeKeywordResponse() {
  var response;
  var values = {};
  for(var i=0; i<keywordValues.length; i++) {
    values[keywordValues[i]] = { "max_place": maxValues[i], "min_place": minValues[i]}
  }
  return {"items": values}
}
