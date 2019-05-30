var searchSS = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("search")
var keywordValues = getNotEmptyValues(searchSS.getRange('A2:A').getValues())
var minValues = getNotEmptyValues(searchSS.getRange('B2:B').getValues())
var maxValues = getNotEmptyValues(searchSS.getRange('C2:C').getValues())


function doGet(e) {
    var response = getResponse(e.parameter.type)
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

function getResponse(type) {
  switch(type) {
    case "keyword":
      return keywordValues;
      break;
    case "min":
      return minValues;
      break;
    case "max":
      return maxValues;
      break;
    default:
      return keywordValues;
  }
}
