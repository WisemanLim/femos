
var scanSuccess = function(result) {
    var textFormats = "QR_CODE DATA_MATRIX";
    var productFormats = "UPC_E UPC_A EAN_8 EAN_13";
    
    if (result.cancelled) {
        return;
    }
    //alert("Scanned Code: " + result.text + ". Format: " + result.format);
    if (textFormats.match(result.format)) {                
        var scanVal = result.text;
        if (scanVal.indexOf("http") === 0) {
            navigator.notification.confirm(
                    '(1) Open in Browser\n(2) Cancel',
                    function (b) {
                        if (b === 1) {
                            window.plugins.childBrowser.openExternal(scanVal);
                        }
                    },
                    result.text,
                    '1, 2'
            );
        } else {
            navigator.notification.alert(
                    result.text,
                    function (){},
                    'Scan Value:',
                    'Done'
                );
        }
    } else if (productFormats.match(result.format)) {
        //alert("Found Product Code: " + result.text  + ". Format: " + result.format);
        navigator.notification.confirm(
                '(1) Look Up Product\n(2) Cancel',
                function (b) {
                    if (b === 1) {
                        // This is an example url with query - substitute your own here
                        var searchUrl = "http://example.com/urserver/search.pl?q=" + result.text;
                        window.plugins.childBrowser.showWebPage(searchUrl);
                    }
                },
                result.text,
                '1, 2' 
        ); 
    } else {
        alert("Scan format : " + result.format + 
              " not supported. Scan value: " + result.text);
    }
};

var scanCode = function() {
window.plugins.barcodeScanner.scan(
        scanSuccess,
        function(error) {
            alert("Scan failed: " + error);
        });
};

var encodeText = function() {
    window.plugins.barcodeScanner.encode(
            BarcodeScanner.Encode.TEXT_TYPE,
            "http://www.mobiledevelopersolutions.com", 
            function(success) {
                alert("Encode success: " + success);
            }, function(fail) {
                alert("Encoding failed: " + fail);
            });
};

var encodeEmail = function() {
    window.plugins.barcodeScanner.encode(
        BarcodeScanner.Encode.EMAIL_TYPE,
        "a.name@gmail.com", function(success) {
            alert("Encode success: " + success);
        }, function(fail) {
            alert("Encoding failed: " + fail);
        });
};

var encodePhone = function() {
    window.plugins.barcodeScanner.encode(
        BarcodeScanner.Encode.PHONE_TYPE,
        "555-227-5283", function(success) {
            alert("Encode success: " + success);
        }, function(fail) {
            alert("Encoding failed: " + fail);
        });
};

var encodeSMS = function() {
    window.plugins.barcodeScanner.encode(
        BarcodeScanner.Encode.SMS_TYPE,
        "An important message for someone.", function(success) {
            alert("Encode success: " + success);
        }, function(fail) {
            alert("Encoding failed: " + fail);
        });
};
