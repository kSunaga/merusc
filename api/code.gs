var searchSS = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("search")
var keywordValues = searchSS.getRange('A2:A').getValues()
var minValues = searchSS.getRange('B2:B').getValues()
var maxValues = searchSS.getRange('C2:C').getValues()

function doGet(e) {
    var out = ContentService.createTextOutput();
    var callback = e.parameter.callback;

    if (callback) {
        responseText = callback + "(" + JSON.stringify(keywordValues) + ")";
        out.setMimeType(ContentService.MimeType.JAVASCRIPT);
    } else {
        responseText = JSON.stringify(keywordValues);
        out.setMimeType(ContentService.MimeType.JSON);
    }
    
    out.setContent(responseText);

    return out;
}
