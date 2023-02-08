import 'dart:ffi';

class KendaraanModel {
  final String? id_kendaraan;
  final String? tipe_kendaraan;
  final String? jenis_kendaraan;
  final String? nomor_polisi;
  final Int? pinjam;

  KendaraanModel(
      {this.id_kendaraan,
      this.tipe_kendaraan,
      this.jenis_kendaraan,
      this.nomor_polisi,
      this.pinjam});

  factory KendaraanModel.fromJson(Map<String, dynamic> json) {
    return KendaraanModel(
      id_kendaraan: json['id_kendaraan'].toString(),
      tipe_kendaraan: json['tipe_kendaraan'],
      jenis_kendaraan: json['jenis_kendaraan'],
      nomor_polisi: json['nomor_polisi'],
      pinjam: json['pinjam'],
    );
  }
}
