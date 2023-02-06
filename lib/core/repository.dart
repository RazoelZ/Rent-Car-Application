import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rentvehicle_application/model/DriverModel.dart';
import 'package:rentvehicle_application/model/HistoryModel.dart';
import 'package:rentvehicle_application/model/KendaraanModel.dart';
import 'package:rentvehicle_application/model/UserModel.dart';
import 'package:rentvehicle_application/model/MainKendaraanModel.dart';
import 'package:rentvehicle_application/model/PeminjamanModel.dart';

//Mengambil data dari table kendaraan
final _baseUrl = "http://192.168.0.104/rent_car/public/";

class Repository {
  Future getData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/kendaraan'));

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

//Mengambil data dari table user 1
class UserRepository {
  Future getData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/user/1'));
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

//Mengambil data dari table mainkendaran untuk page home
class MainKendaraanRepository {
  Future getData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/mainkendaraan'));
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

//Mengirim data ke table peminjaman

class PeminjamanRepository {
  Future getData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/peminjaman'));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<Peminjaman> peminjaman = List<Peminjaman>.from(
            it.map((e) => Peminjaman.fromJson(e)).toList());
        return peminjaman;
      } else {
        Get.snackbar("Error", "Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postPeminjamanData(
    String id_kendaraan,
    String id_user,
    String tgl_peminjaman,
    String jam_peminjaman,
    String km_awal,
    String saldo_tol_awal,
    String keperluan,
    String driver,
    String tujuan,
  ) async {
    try {
      final response =
          await http.post(Uri.parse(_baseUrl + '/peminjaman'), body: {
        "id_kendaraan": id_kendaraan,
        "id_user": id_user,
        "tgl_peminjaman": tgl_peminjaman,
        "jam_peminjaman": jam_peminjaman,
        "km_awal": km_awal,
        "saldo_tol_awal": saldo_tol_awal,
        "keperluan": keperluan,
        "driver": driver,
        "tujuan": tujuan,
      });
      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      int status = jsonMap['status'];
      if (status == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {}
  }

  Future putPeminjamanData(
      String id,
      String tgl_kembali,
      String jam_kembali,
      String km_akhir,
      String saldo_tol_akhir,
      String hargabbm,
      String lampiran_tol,
      String lampiran_bbm) async {
    try {
      final response =
          await http.put(Uri.parse('$_baseUrl/peminjaman/$id'), body: {
        "tgl_kembali": tgl_kembali,
        "jam_kembali": jam_kembali,
        "km_akhir": km_akhir.toString(),
        "saldo_tol_akhir": saldo_tol_akhir.toString(),
        "hargabbm": hargabbm.toString(),
        "lampiran_tol": lampiran_tol,
        "lampiran_bbm": lampiran_bbm,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class DriverRepository {
  Future getDriverData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/driver'));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<DriverModel> driverModel = List<DriverModel>.from(
            it.map((e) => DriverModel.fromJson(e)).toList());
        return driverModel;
      } else {
        Get.snackbar("Error", "Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class HistoryRepository {
  Future getData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/historylog'));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<HistoryLogModel> historyLogModel = List<HistoryLogModel>.from(
            it.map((e) => HistoryLogModel.fromJson(e)).toList());
        return historyLogModel;
      } else {
        Get.snackbar("Error", "Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
