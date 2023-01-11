import 'package:flutter/material.dart';

class RentPage extends StatefulWidget {
  const RentPage({super.key});

  @override
  State<RentPage> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Peminjaman"),
      ),
      body: Container(
        child: ListTile(
          title: Text("Nama Kendaraan"),
          subtitle: Text("Tipe Kendaraan"),
          trailing: Text("Nomor Polisi"),
        ),
      ),
    );
  }
}
