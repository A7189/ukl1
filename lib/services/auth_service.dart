import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('https://learn.smktelkom-mlg.sch.id/ukl1/api/login');

    final response = await http.post(url, body: {
      'username': username,
      'password': password,
    });

    return json.decode(response.body);
  }
}
