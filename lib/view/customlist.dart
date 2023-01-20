import 'package:flutter/material.dart';
import 'package:rentvehicle_application/view/kendaraancard.dart';

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    super.key,
    required this.thumbnail,
    required this.nama_kendaraan,
    required this.lokasi,
    required this.nomor_polisi,
  });

  final Widget thumbnail;
  final String nama_kendaraan;
  final String lokasi;
  final String nomor_polisi;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: thumbnail,
          ),
          Expanded(
            flex: 3,
            child: KendaraanDescription(
              nama_kendaraan: nama_kendaraan,
              lokasi: lokasi,
              nomor_polisi: nomor_polisi,
            ),
          ),
          ElevatedButton(onPressed: () {}, child: Text("Detail"))
        ],
      ),
    );
  }
}
