import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailPeminjamanPage extends StatefulWidget {
  const DetailPeminjamanPage({super.key});

  @override
  State<DetailPeminjamanPage> createState() => _DetailPeminjamanPageState();
}

class _DetailPeminjamanPageState extends State<DetailPeminjamanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Detail Peminjaman"),
      ),
      body: Container(
        child: Column(
          children: [
            Text("Detail Peminjaman"),
          ],
        ),
      ),
    );
  }
}
