import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rentvehicle_application/model/KendaraanModel.dart';
import 'package:rentvehicle_application/model/UserModel.dart';
import 'package:rentvehicle_application/model/MainKendaraanModel.dart';

class Repository {
  final _baseUrl = "http://192.168.1.70/rent_car/public/kendaraan";

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<KendaraanModel> kendaraanModel = List<KendaraanModel>.from(
            it.map((e) => KendaraanModel.fromJson(e)).toList());
        return kendaraanModel;
      } else {
        Get.snackbar("Error", "Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class UserRepository {
  final _baseUrl = "http://192.168.1.70/rent_car/public/user/1";

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        jsonDecode(response.body);
        User user = User.fromJson(jsonDecode(response.body));
        return user;
      } else {
        Get.snackbar("Error", "Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class MainKendaraanRepository {
  final _baseUrl = "http://192.168.1.70/rent_car/public/mainkendaraan";

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      print(response.body);
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<MainKendaraan> mainKendaraan = List<MainKendaraan>.from(
            it.map((e) => MainKendaraan.fromJson(e)).toList());
        return mainKendaraan;
      } else {
        Get.snackbar("Error", "Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
