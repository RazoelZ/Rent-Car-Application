import 'dart:convert';
import 'package:http/http.dart' as http;

class Peminjaman {
  final String? id_peminjaman;
  final String? id_kendaraan;
  final String? id_user;
  final String? tgl_peminjaman;
  final String? jam_peminjaman;
  final String? km_awal;
  final String? saldo_tol_awal;
  final String? tgl_kembali;
  final String? jam_kembali;
  final String? km_akhir;
  final String? saldo_tol_akhir;
  final String? keperluan;
  final String? driver;
  final String? tujuan;
  final String? bbm;
  final String? lampiran_tol;
  final String? lampiran_bbm;
  final String? total_km;

  Peminjaman({
    this.id_peminjaman,
    this.id_kendaraan,
    this.id_user,
    this.tgl_peminjaman,
    this.jam_peminjaman,
    this.km_awal,
    this.saldo_tol_awal,
    this.tgl_kembali,
    this.jam_kembali,
    this.km_akhir,
    this.saldo_tol_akhir,
    this.keperluan,
    this.driver,
    this.tujuan,
    this.bbm,
    this.lampiran_tol,
    this.lampiran_bbm,
    this.total_km,
  });

  factory Peminjaman.fromJson(Map<String, dynamic> json) {
    return Peminjaman(
      id_peminjaman: json['id_peminjaman'],
      id_kendaraan: json['id_kendaraan'],
      id_user: json['id_user'],
      tgl_peminjaman: json['tgl_peminjaman'],
      jam_peminjaman: json['jam_peminjaman'],
      km_awal: json['km_awal'],
      saldo_tol_awal: json['saldo_tol_awal'],
      tgl_kembali: json['tgl_kembali'],
      jam_kembali: json['jam_kembali'],
      km_akhir: json['km_akhir'],
      saldo_tol_akhir: json['saldo_tol_akhir'],
      keperluan: json['keperluan'],
      driver: json['driver'],
      tujuan: json['tujuan'],
      bbm: json['bbm'],
      lampiran_tol: json['lampiran_tol'],
      lampiran_bbm: json['lampiran_bbm'],
      total_km: json['total_km'],
    );
  }
}
