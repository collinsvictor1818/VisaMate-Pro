import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> makePayBillPayment(String businessShortCode, String passKey, String amount, String phoneNumber) async {
  String timestamp = DateTime.now().millisecondsSinceEpoch.toString().substring(0, 10);
  String password = base64.encode(utf8.encode(businessShortCode + passKey + timestamp));
  String url = "https://api.safaricom.co.ke/mpesa/stkpush/v1/processrequest";
  String callbackUrl = "https://your-callback-url.com";
  
  var body = jsonEncode({
    "BusinessShortCode": businessShortCode,
    "Password": password,
    "Timestamp": timestamp,
    "TransactionType": "CustomerPayBillOnline",
    "Amount": amount,
    "PartyA": phoneNumber,
    "PartyB": businessShortCode,
    "PhoneNumber": phoneNumber,
    "CallBackURL": callbackUrl,
    "AccountReference": "YourAccountReference",
    "TransactionDesc": "YourTransactionDescription"
  });

  var headers = {
    "Authorization": "Bearer your-access-token",
    "Content-Type": "application/json"
  };

  var response = await http.post(url as Uri, body: body, headers: headers);
  
  if (response.statusCode == 200) {
    // Payment request successful, parse response JSON and handle accordingly
  } else {
    // Payment request failed, handle error
  }
}
