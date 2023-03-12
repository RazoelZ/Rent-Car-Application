import 'package:flutter/material.dart';
import 'package:DESARMADA/screen/Peminjaman.dart';

import '../constants.dart';

class DetailKendaraanPage extends StatefulWidget {
  final String? id_kendaraan;
  final String? tipe_kendaraan;
  final String? nomor_polisi;
  final String? nama_departemen;
  final String? jenis_kendaraan;
  final String? km;
  final String? gambar;

  const DetailKendaraanPage({
    Key? key,
    this.id_kendaraan,
    this.tipe_kendaraan,
    this.nomor_polisi,
    this.nama_departemen,
    this.jenis_kendaraan,
    this.km,
    this.gambar,
  }) : super(key: key);
  @override
  State<DetailKendaraanPage> createState() => _DetailKendaraanPageState();
}

class _DetailKendaraanPageState extends State<DetailKendaraanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tipe_kendaraan!),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Image.network(
                  '$kBASE_URL/assets/img_kendaraan/${widget.gambar}',
                  fit: BoxFit.contain,
                  width: 200,
                  height: 200,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  readOnly: true,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Tipe Kendaraan",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.tipe_kendaraan,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  readOnly: true,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Nomor Polisi",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.nomor_polisi,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  readOnly: true,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Jenis Kendaraan",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.jenis_kendaraan,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  readOnly: true,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Lokasi",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.nama_departemen,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  readOnly: true,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: "Total Kilometer",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.km,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PeminjamanPage(
                          id_kendaraan: widget.id_kendaraan!,
                          tipe_kendaraan: widget.tipe_kendaraan!,
                        ),
                      ),
                    );
                  },
                  child: Text("Pinjam kendaraan"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
