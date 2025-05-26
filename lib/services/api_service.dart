import 'dart:convert';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl =
      'https://learn.smktelkom-mlg.sch.id/ukl1/api';

  static Future<Map<String, dynamic>> register(UserModel user) async {
    var response = await http.post(
      Uri.parse('$_baseUrl/register'),
      body: user.toJson(),
    );

    return json.decode(response.body);
  }
}
