import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class RegisterController {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController teleponController = TextEditingController();
  final TextEditingController fotoController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<String> register() async {
    UserModel user = UserModel(
      namaNasabah: namaController.text,
      gender: genderController.text,
      alamat: alamatController.text,
      telepon: teleponController.text,
      foto: fotoController.text,
      username: usernameController.text,
      password: passwordController.text,
    );

    var result = await ApiService.register(user);
    if (result['status'] == true) {
      return result['message'];
    } else {
      throw Exception(result['message']);
    }
  }
}
