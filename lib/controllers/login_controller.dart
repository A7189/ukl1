import 'package:flutter/material.dart';
import '../services/auth_service.dart';
// Make sure AuthService is defined in the imported file or define it below if missing.

class LoginController {
  final TextEditingController username = TextEditingController(text: "ukl_paket1");
  final TextEditingController password = TextEditingController(text: "12345678");

  void login(BuildContext context) async {
    final response = await AuthService.login(username.text, password.text);

    if (response['status']) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Berhasil"),
          content: Text(response['message']),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Gagal"),
          content: Text(response['message']),
        ),
      );
    }
  }
}
