import 'dart:convert';

import 'package:http/http.dart' as http;

class VisaAPI {
  static const String baseUrl = "https://your-actual-gemini-endpoint.com";

  Future<Map<String, dynamic>> getVisaOptions(Map<String, dynamic> userInfo) async {
    final url = Uri.parse("$baseUrl/getVisaOptions");
    final response = await http.post(url, body: jsonEncode(userInfo));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get visa options");
    }
  }

  Future<Map<String, dynamic>> getVisaDetails(String visa, String country) async {
    final url = Uri.parse("$baseUrl/getVisaDetails");
    final response = await http.post(url, body: {"visa": visa, "country": country});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get visa details");
    }
  }
}
