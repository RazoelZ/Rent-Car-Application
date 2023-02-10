class User {
  final String? id_user;
  final String? id_driver;
  final String? username;
  final String? password;
  final String? nama;

  User({
    this.id_user,
    this.id_driver,
    this.username,
    this.password,
    this.nama,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id_user: json['id_user'],
      id_driver: json['id_driver'],
      username: json['username'],
      password: json['password'],
      nama: json['nama'],
    );
  }
}
