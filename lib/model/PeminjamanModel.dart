class Peminjaman {
  final String? id_peminjaman;
  final String? id_kendaraan;
  final String? id_user;
  final DateTime? tgl_peminjaman;
  final DateTime? jam_peminjaman;
  final String? km_awal;
  final String? saldo_tol_awal;
  final DateTime? tgl_kembali;
  final DateTime? jam_kembali;
  final String? km_akhir;
  final String? saldo_tol_akhir;
  final String? keperluan;
  final String? driver;
  final String? tujuan;
  final String? hargabbm;
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
    this.hargabbm,
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
      hargabbm: json['hargabbm'],
      lampiran_tol: json['lampiran_tol'],
      lampiran_bbm: json['lampiran_bbm'],
      total_km: json['total_km'],
    );
  }
  // Map<String, dynamic> toJson() => {
  //       "id_kendaraan": id_kendaraan,
  //       "id_user": id_user,
  //       "tgl_peminjaman":
  //           "${tgl_peminjaman!.year.toString().padLeft(4, '0')}-${tgl_peminjaman!.month.toString().padLeft(2, '0')}-${tgl_peminjaman!.day.toString().padLeft(2, '0')}",
  //       "jam_peminjaman": jam_peminjaman,
  //       "km_awal": km_awal,
  //       "saldo_tol_awal": saldo_tol_awal,
  //       "tgl_kembali":
  //           "${tgl_kembali!.year.toString().padLeft(4, '0')}-${tgl_kembali!.month.toString().padLeft(2, '0')}-${tgl_kembali!.day.toString().padLeft(2, '0')}",
  //       "jam_kembali": jam_kembali,
  //       "km_akhir": km_akhir,
  //       "saldo_tol_akhir": saldo_tol_akhir,
  //       "keperluan": keperluan,
  //       "driver": driver,
  //       "tujuan": tujuan,
  //       "hargabbm": harga_bbm,
  //       "lampiran_tol": lampiran_tol,
  //       "lampiran_bbm": lampiran_bbm,
  //       "total_km": total_km,
  //     };
}
