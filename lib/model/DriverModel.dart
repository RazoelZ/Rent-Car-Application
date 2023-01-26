import 'dart:convert';
import 'package:http/http.dart' as http;

class DriverModel {
  final String? id_driver;
  final String? nama;

  DriverModel({
    this.id_driver,
    this.nama,
  });

  static List<DriverModel>? fromJsonList(List list) {
    if (list == null) return null;
    return list.map((item) => DriverModel.fromJson(item)).toList();
  }

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id_driver: json['id_driver'],
      nama: json['nama'],
    );
  }
}
