import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rentvehicle_application/model/KendaraanModel.dart';
import 'package:rentvehicle_application/model/UserModel.dart';
import 'package:rentvehicle_application/model/MainKendaraanModel.dart';
import 'package:rentvehicle_application/model/PeminjamanModel.dart';

//Mengambil data dari table kendaraan
class Repository {
  final _baseUrl = "http://192.168.0.105/rent_car/public";

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
  final _baseUrl = "http://192.168.0.105/rent_car/public";

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
  final _baseUrl = "http://192.168.0.105/rent_car/public";

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
  final _baseUrl = "http://192.168.0.105/rent_car/public";

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
      print(tgl_peminjaman);
      if (response.statusCode == 200) {
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
          await http.put(Uri.parse(_baseUrl + '/peminjaman/$id'), body: {
        "tgl_kembali": tgl_kembali,
        "jam_kembali": jam_kembali,
        "km_akhir": km_akhir.toString(),
        "saldo_tol_akhir": saldo_tol_akhir.toString(),
        "hargabbm": hargabbm.toString(),
        "lampiran_tol": lampiran_tol,
        "lampiran_bbm": lampiran_bbm,
      });
      print(response.body);
      print(jam_kembali);
      print(tgl_kembali);

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

// class buangan{

//             String? tgl_kembali,
//       String? jam_kembali,
//             int? km_akhir,
//       String? saldo_tol_akhir,
//             String? bbm,
//       String? lampiran_tol,
//       String? lampiran_bbm,
//       int? total_km
// }

// "tgl_peminjaman":
//             "${tgl_peminjaman.year.toString().padLeft(4, '0')}-${tgl_peminjaman.month.toString().padLeft(2, '0')}-${tgl_peminjaman.day.toString().padLeft(2, '0')}",
//         "jam_peminjaman":
//             "${jam_peminjaman.hour.toString().padLeft(4, '0')}-${jam_peminjaman.minute.toString().padLeft(2, '0')}-${jam_peminjaman.second.toString().padLeft(2, '0')}",

      