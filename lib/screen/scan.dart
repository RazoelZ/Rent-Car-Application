import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:rentvehicle_application/core/repository.dart';
import 'package:rentvehicle_application/model/KendaraanModel.dart';
import 'package:rentvehicle_application/screen/Peminjaman.dart';
import 'package:rentvehicle_application/screen/fototototo.dart';
import 'package:rentvehicle_application/screen/pengembalian.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String? cameraScanResult = null;
  KendaraanRepository kendaraanRepository = KendaraanRepository();
  List<KendaraanModel> kendaraan = [];

  String? status;

  getData() async {
    var data = await kendaraanRepository.getData();
    setState(() {
      data.forEach((element) {
        if (element.nomor_polisi.toString() == cameraScanResult.toString()) {
          kendaraan.add(element);
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    cameraScanResult = 'BQ671TR';
  }
  //tanya caranya biar bisa langsung ke halaman peminjaman

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Scan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                cameraScanResult = await scanner.scan();
                kendaraan.clear();
                setState(() {
                  getData();
                });
              },
              child: const Text('Scan'),
            ),
            Text((cameraScanResult == null)
                ? 'Nomor plat kendaraan : belum ada'
                : 'Nomor plat kendaraan : $cameraScanResult'),
            if (kendaraan.isEmpty == true)
              Text("gaada data")
            else if (kendaraan[0].pinjam.toString() == "0")
              ElevatedButton(
                  onPressed: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PeminjamanPage(
                          id_kendaraan: kendaraan[0].id_kendaraan.toString(),
                          tipe_kendaraan:
                              kendaraan[0].tipe_kendaraan.toString(),
                        ),
                      ),
                    );
                  }),
                  child: Text("Pinjam"))
            else
              ElevatedButton(
                  onPressed: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PengembalianPage(
                          id_kendaraan: kendaraan[0].id_kendaraan.toString(),
                          km: kendaraan[0].km.toString(),
                          total_saldo_tol:
                              kendaraan[0].total_saldo_tol.toString(),
                        ),
                      ),
                    );
                  }),
                  child: Text("Kembalikan")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FotoPage(),
                    ),
                  );
                },
                child: Text("upload foto"))
          ],
        ),
      ),
    );
  }
}
