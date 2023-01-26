import 'dart:convert';
import 'package:http/http.dart' as http;

class HistoryLogModel {
  String? id;
  String? idUser;
  String? idKendaraan;
  String? namaDepartemen;
  String? tipeKendaraan;
  String? nomorPolisi;
  String? jenisKendaraan;
  String? tglPeminjaman;
  String? jamPeminjaman;
  String? kmAwal;
  String? saldoTolAwal;
  String? tglKembali;
  String? jamKembali;
  String? kmAkhir;
  String? saldoTolAkhir;
  String? keperluan;
  String? driver;
  String? tujuan;
  String? hargabbm;
  String? lampiranTol;
  String? lampiranBbm;
  int? totalKm;

  HistoryLogModel({
    this.id,
    this.idUser,
    this.idKendaraan,
    this.namaDepartemen,
    this.tipeKendaraan,
    this.nomorPolisi,
    this.jenisKendaraan,
    this.tglPeminjaman,
    this.jamPeminjaman,
    this.kmAwal,
    this.saldoTolAwal,
    this.tglKembali,
    this.jamKembali,
    this.kmAkhir,
    this.saldoTolAkhir,
    this.keperluan,
    this.driver,
    this.tujuan,
    this.hargabbm,
    this.lampiranTol,
    this.lampiranBbm,
    this.totalKm,
  });

  factory HistoryLogModel.fromJson(Map<String, dynamic> json) =>
      HistoryLogModel(
        idUser: json["id_user"],
        idKendaraan: json["id_kendaraan"],
        namaDepartemen: json["nama_departemen"],
        tipeKendaraan: json["tipe_kendaraan"],
        nomorPolisi: json["nomor_polisi"],
        jenisKendaraan: json["jenis_kendaraan"],
        tglPeminjaman: json["tgl_peminjaman"],
        jamPeminjaman: json["jam_peminjaman"],
        kmAwal: json["km_awal"],
        saldoTolAwal: json["saldo_tol_awal"],
        tglKembali: json["tgl_kembali"],
        jamKembali: json["jam_kembali"],
        kmAkhir: json["km_akhir"],
        saldoTolAkhir: json["saldo_tol_akhir"],
        keperluan: json["keperluan"],
        driver: json["driver"],
        tujuan: json["tujuan"],
        hargabbm: json["hargabbm"],
        lampiranTol: json["lampiran_tol"],
        lampiranBbm: json["lampiran_bbm"],
        totalKm: json["total_km"],
      );
}
