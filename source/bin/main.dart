
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

main(List<String> arguments) async {

  var _nonce = DateTime.now().millisecondsSinceEpoch;
  String _commandLine = "command=returnBalances&nonce=$_nonce";

  String _apiKey = 'Your "API Key" from https://poloniex.com/apiKeys';
  String _apiSecret = 'Your "Secret" from https://poloniex.com/apiKeys';

  var _apiSecretBytes = utf8.encode(_apiSecret); 
  var _hmacSha512 = Hmac(sha512, _apiSecretBytes);

  var _encodedCommand = utf8.encode(_commandLine);
  var _digest = _hmacSha512.convert(_encodedCommand);

  var _uri = "https://poloniex.com/tradingApi";
  var _client = http.Client();

  String _responseBody = "The request has failed.";

  try {
    var _response = await _client.post(_uri,
        body: _commandLine,
        headers: {
          "Key":  _apiKey,
          "Sign": _digest.toString(),
          "Content-Type": "application/x-www-form-urlencoded"
        }
    ); 
    
    var _statusCode= _response.statusCode;
    _responseBody = _response.body;

    if(_statusCode!=200) {
      print("Unsucceful response with status code $_statusCode");
     }

  } catch (e) {
    print(e);
  } finally {
    _client.close();
  }

  print(_responseBody);

}
