import 'package:flutter/material.dart';

class KendaraanDescription extends StatelessWidget {
  const KendaraanDescription({
    super.key,
    required this.nama_kendaraan,
    required this.lokasi,
    required this.nomor_polisi,
  });

  final String nama_kendaraan;
  final String lokasi;
  final String nomor_polisi;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            nama_kendaraan,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            "Lokasi : $lokasi",
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
          Text(
            'Plat Nomor : $nomor_polisi',
            style: const TextStyle(fontSize: 10.0),
          ),
        ],
      ),
    );
  }
}
