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
  var values = [];
  for(var i=0; i<keywordValues.length; i++) {
    values.push({ "keyword": keywordValues[i], "max_place": maxValues[i], "min_place": minValues[i]})
  }
  return {"items": values}
}

function doPost(e) {

  var data = JSON.parse(e.postData.contents);
  var keyword = data.keyword;
  var min_place = data.min_place;
  var max_place = data.max_place;
  var response = ContentService.createTextOutput();

  if(keyword && min_place && max_place) {
    searchSS.appendRow([keyword, min_place, max_place]);
    return response.setContent(JSON.stringify({message: "成功"}))
  }else{
    return response.setContent(JSON.stringify({message: "失敗"}))
  }
}
