import 'dart:ffi';

class KendaraanModel {
  final String? id_kendaraan;
  final String? id_departemen;
  final String? jenis_kendaraan;
  final String? nomor_polisi;
  final String? tipe_kendaraan;
  final String? km;
  final String? total_saldo_tol;
  final String? pinjam;
  final String? gambar;

  KendaraanModel(
      {this.id_kendaraan,
      this.id_departemen,
      this.jenis_kendaraan,
      this.nomor_polisi,
      this.tipe_kendaraan,
      this.km,
      this.total_saldo_tol,
      this.pinjam,
      this.gambar});

  factory KendaraanModel.fromJson(Map<String, dynamic> json) {
    return KendaraanModel(
      id_kendaraan: json['id_kendaraan'].toString(),
      id_departemen: json['id_departemen'].toString(),
      jenis_kendaraan: json['jenis_kendaraan'],
      nomor_polisi: json['nomor_polisi'],
      tipe_kendaraan: json['tipe_kendaraan'],
      km: json['km'],
      total_saldo_tol: json['total_saldo_tol'].toString(),
      pinjam: json['pinjam'],
      gambar: json['gambar'],
    );
  }
}
