import 'dart:convert';
import 'package:http/http.dart' as http;

const String consumerKey = 'MGSTi2E0vYJ162VnIvCKV6PVxQTaQfP6';
const String consumerSecret = 'cbJSrMvF5q6Z62U1';

Future<String> getAccessToken() async {
  final response = await http.get(
    Uri.parse('https://api.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials'),
    headers: {
      'Authorization': 'Basic ' + base64Encode(utf8.encode('$consumerKey:$consumerSecret')),
      'Content-Type': 'application/json'
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final accessToken = data['access_token'] as String;
    return accessToken;
  } else {
    throw Exception('Failed to authenticate with M-Pesa Daraja API');
  }
}

