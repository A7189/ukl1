class UserModel {
  String namaNasabah;
  String gender;
  String alamat;
  String telepon;
  String foto;
  String username;
  String password;

  UserModel({
    required this.namaNasabah,
    required this.gender,
    required this.alamat,
    required this.telepon,
    required this.foto,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "nama_nasabah": namaNasabah,
        "gender": gender,
        "alamat": alamat,
        "telepon": telepon,
        "username": username,
        "password": password,
        "image": foto,
      };
}
