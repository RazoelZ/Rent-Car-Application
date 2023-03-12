import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:DESARMADA/constants.dart';
import 'package:DESARMADA/model/DriverModel.dart';
import 'package:DESARMADA/model/HistoryModel.dart';
import 'package:DESARMADA/model/KendaraanModel.dart';
import 'package:DESARMADA/model/UserModel.dart';
import 'package:DESARMADA/model/MainKendaraanModel.dart';
import 'package:DESARMADA/model/PeminjamanModel.dart';

//API link
const _baseUrl = '${kBASE_URL}/api';

//Mengambil data kendaraan
class KendaraanRepository {
  Future getData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/kendaraan'));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<KendaraanModel> kendaraan = List<KendaraanModel>.from(
            it.map((e) => KendaraanModel.fromJson(e)).toList());
        return kendaraan;
      } else {
        Get.snackbar("Error", "Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //update kendaraan dipinjam
  Future updateStatusKendaraan(
    String id_kendaraan,
    int pinjam,
  ) async {
    try {
      final response =
          await http.put(Uri.parse('$_baseUrl/kendaraan/$id_kendaraan'), body: {
        "pinjam": "1",
      });
      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      int status = jsonMap['status'];
      if (status == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //update status pengembalian sudah dikembalikan
  Future updateStatusKendaraanKembali(
    String id_kendaraan,
    int pinjam,
    String km,
    String total_saldo_tol,
  ) async {
    try {
      final response =
          await http.put(Uri.parse('$_baseUrl/kendaraan/$id_kendaraan'), body: {
        "pinjam": "0",
        "km": km.toString(),
        "total_saldo_tol": total_saldo_tol.toString(),
      });
      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      int status = jsonMap['status'];
      if (status == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

//Mengambil data user
class UserRepository {
  Future getData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/user'));
      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<User> user =
            List<User>.from(it.map((e) => User.fromJson(e)).toList());
        return user;
      } else {
        Get.snackbar("Error", "Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //update password user
  Future updatePassword(
    String id_user,
    String password,
  ) async {
    try {
      final response =
          await http.put(Uri.parse('$_baseUrl/user/$id_user'), body: {
        "password": password,
      });
      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      int status = jsonMap['status'];
      if (status == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

//Mengambil data mainkendaran
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

//Mengambil data ke table peminjaman
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

  //membuat peminjaman
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

  //update peminjaman atau disebut pengembaliannya
  Future putPeminjamanData(
      String id,
      String tgl_kembali,
      String jam_kembali,
      String km_akhir,
      String saldo_tol_akhir,
      String hargabbm,
      String lampiran_tol,
      String lampiran_bbm,
      String total_km) async {
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
        "total_km": total_km,
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

//Mengambil data driver
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

//mengambil data history
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
