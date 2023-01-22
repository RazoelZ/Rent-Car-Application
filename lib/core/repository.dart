import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rentvehicle_application/model/KendaraanModel.dart';
import 'package:rentvehicle_application/model/UserModel.dart';
import 'package:rentvehicle_application/model/MainKendaraanModel.dart';
import 'package:rentvehicle_application/model/PeminjamanModel.dart';

//Mengambil data dari table kendaraan
class Repository {
  final _baseUrl = "http://192.168.0.103/rent_car/public";

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
  final _baseUrl = "http://192.168.0.103/rent_car/public";

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
  final _baseUrl = "http://192.168.0.103/rent_car/public";

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
  final _baseUrl = "http://192.168.0.103/rent_car/public";

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

  Future postdata(
      String id_kendaraan,
      String id_user,
      DateTime tgl_peminjaman,
      DateTime jam_peminjaman,
      Int km_awal,
      String saldo_tol_awal,
      DateTime tgl_kembali,
      DateTime jam_kembali,
      int km_akhir,
      String saldo_tol_akhir,
      String keperluan,
      String driver,
      String tujuan,
      String bbm,
      String lampiran_tol,
      String lampiran_bbm,
      int total_km) async {
    try {
      final response =
          await http.post(Uri.parse(_baseUrl + 'peminjaman'), body: {
        'id_kendaraan': id_kendaraan,
        'id_user': id_user,
        'tgl_peminjaman': tgl_peminjaman,
        'jam_peminjaman': jam_peminjaman,
        'km_awal': km_awal,
        'saldo_tol_awal': saldo_tol_awal,
        'tgl_kembali': tgl_kembali,
        'jam_kembali': jam_kembali,
        'km_akhir': km_akhir,
        'saldo_tol_akhir': saldo_tol_akhir,
        'keperluan': keperluan,
        'driver': driver,
        'tujuan': tujuan,
        'bbm': bbm,
        'lampiran_tol': lampiran_tol,
        'lampiran_bbm': lampiran_bbm,
        'total_km': total_km,
      });

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {}
  }
}
