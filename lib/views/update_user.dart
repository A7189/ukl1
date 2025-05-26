import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController teleponController = TextEditingController();

  Map<String, String> originalData = {};

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    final response = await http.get(
      Uri.parse('https://learn.smktelkom-mlg.sch.id/ukl1/api/profil'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final user = data['data'];

      setState(() {
        namaController.text = user['nama_pelanggan'];
        alamatController.text = user['alamat'];
        genderController.text = user['gender'];
        teleponController.text = user['telepon'];

        originalData = {
          'nama_pelanggan': user['nama_pelanggan'],
          'alamat': user['alamat'],
          'gender': user['gender'],
          'telepon': user['telepon'],
        };
      });
    }
  }

  Future<void> updateProfile() async {
    final currentData = {
      'nama_pelanggan': namaController.text.trim(),
      'alamat': alamatController.text.trim(),
      'gender': genderController.text.trim(),
      'telepon': teleponController.text.trim(),
    };

    final hasEmpty = currentData.values.any((value) => value.isEmpty);
    final isSame = currentData.entries.every(
      (entry) => originalData[entry.key] == entry.value,
    );

    if (hasEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Semua field harus diisi."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (isSame) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tidak ada perubahan data untuk diupdate."),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final response = await http.put(
      Uri.parse('https://learn.smktelkom-mlg.sch.id/ukl1/api/update/1'),
      body: currentData,
    );

    final data = jsonDecode(response.body);
    final isSuccess = data['status'];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isSuccess ? 'Profil berhasil diupdate' : 'Gagal update profil'),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );

    if (isSuccess) {
      setState(() {
        originalData = currentData;
      });
    }
  }

  Widget buildTextBox(String label, TextEditingController controller,
      {TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4CAF50), // hijau
              Colors.white,      // putih
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            width: 340,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFF88BBC2),
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  buildTextBox('Nama Pelanggan', namaController),
                  const SizedBox(height: 10),
                  buildTextBox('Alamat', alamatController),
                  const SizedBox(height: 10),
                  buildTextBox('Gender', genderController),
                  const SizedBox(height: 10),
                  buildTextBox('Telepon', teleponController,
                      keyboardType: TextInputType.phone),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: updateProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Update Profil',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
