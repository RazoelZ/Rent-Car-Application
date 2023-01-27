import 'package:flutter/material.dart';

class DetailPeminjamanPage extends StatefulWidget {
  final String id;
  final String idKendaraan;
  final String namaDepartemen;
  final String tglPeminjaman;
  final String tglPengembalian;
  final String jamPeminjaman;
  final String jamKembali;
  final String tipeKendaraan;
  final String jeniskendaraan;
  final String kmAwal;
  final String kmAkhir;
  final String tujuan;
  final String keperluan;
  final String driver;
  final String platNomor;

  const DetailPeminjamanPage({
    Key? key,
    required this.id,
    required this.idKendaraan,
    required this.namaDepartemen,
    required this.tglPeminjaman,
    required this.tglPengembalian,
    required this.jamPeminjaman,
    required this.jamKembali,
    required this.tipeKendaraan,
    required this.jeniskendaraan,
    required this.kmAwal,
    required this.kmAkhir,
    required this.tujuan,
    required this.keperluan,
    required this.driver,
    required this.platNomor,
  }) : super(key: key);
  @override
  State<DetailPeminjamanPage> createState() => _DetailPeminjamanPageState();
}

class _DetailPeminjamanPageState extends State<DetailPeminjamanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Peminjaman"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              Container(
                // child: Image.network(widget.gambar!),
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Tipe Kendaraan",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.tipeKendaraan,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Jenis Kendaraan",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.jeniskendaraan,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Nomor Polisi",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.platNomor,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Lokasi",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.namaDepartemen,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Tanggal Peminjaman",
                          border: OutlineInputBorder(),
                        ),
                        initialValue: widget.tglPeminjaman,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Tanggal Pengembalian",
                          border: OutlineInputBorder(),
                        ),
                        initialValue: widget.tglPengembalian,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Jam Peminjaman",
                          border: OutlineInputBorder(),
                        ),
                        initialValue: widget.jamPeminjaman,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Jam Pengembalian",
                          border: OutlineInputBorder(),
                        ),
                        initialValue: widget.jamKembali,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Km Awal",
                          border: OutlineInputBorder(),
                        ),
                        initialValue: widget.kmAwal,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Km Akhir",
                          border: OutlineInputBorder(),
                        ),
                        initialValue: widget.kmAkhir,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Driver",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.driver,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Tujuan",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.tujuan,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Keperluan",
                    border: OutlineInputBorder(),
                  ),
                  initialValue: widget.keperluan,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Kembali"),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
