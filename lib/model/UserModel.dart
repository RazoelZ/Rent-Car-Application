class User {
  final String? id_user;
  final String? nama;
  final String? username;

  User({this.id_user, this.nama, this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id_user: json['id_user'].toString(),
      nama: json['nama'],
      username: json['username'],
    );
  }
}
