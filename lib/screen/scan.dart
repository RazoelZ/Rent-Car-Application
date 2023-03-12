import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:DESARMADA/core/repository.dart';
import 'package:DESARMADA/model/KendaraanModel.dart';
import 'package:DESARMADA/screen/Peminjaman.dart';
import 'package:DESARMADA/screen/pengembalian.dart';

import '../constants.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String? cameraScanResult;
  KendaraanRepository kendaraanRepository = KendaraanRepository();
  List<KendaraanModel> kendaraan = [];

  String? status;

  //mengambil data kendaraan
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
  }
  //tanya caranya biar bisa langsung ke halaman peminjaman

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Scan qr-qode'),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (kendaraan.isEmpty == true)
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.contain,
                  width: 300,
                  height: 200,
                ),
              )
            else
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Image.network(
                    '$kBASE_URL/assets/img_kendaraan/' +
                        kendaraan[0].gambar.toString(),
                    fit: BoxFit.contain,
                    width: 300,
                    height: 200),
              ),
            Text((cameraScanResult == null)
                ? 'Nomor plat kendaraan : belum ada'
                : 'Nomor plat kendaraan : $cameraScanResult'),
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
            if (kendaraan.isEmpty == true)
              Text("")
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
          ],
        ),
      ),
    );
  }
}
