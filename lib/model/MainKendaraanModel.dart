class MainKendaraan {
  final String? id_kendaraan;
  final String? tipe_kendaraan;
  final String? nomor_polisi;
  final String? nama_departemen;
  final String? jenis_kendaraan;
  final String? km;
  final String? gambar;
  final String? pinjam;

  MainKendaraan({
    this.id_kendaraan,
    this.tipe_kendaraan,
    this.nomor_polisi,
    this.nama_departemen,
    this.jenis_kendaraan,
    this.km,
    this.gambar,
    this.pinjam,
  });

  factory MainKendaraan.fromJson(Map<String, dynamic> json) {
    return MainKendaraan(
      id_kendaraan: json['id_kendaraan'],
      tipe_kendaraan: json['tipe_kendaraan'],
      nomor_polisi: json['nomor_polisi'],
      nama_departemen: json['nama_departemen'],
      jenis_kendaraan: json['jenis_kendaraan'],
      km: json['km'],
      gambar: json['gambar'],
      pinjam: json['pinjam'],
    );
  }
}
