import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:rentvehicle_application/screen/foto.dart';
import 'package:rentvehicle_application/screen/pengembalian.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String? cameraScanResult;
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
                setState(() {});
              },
              child: const Text('Scan'),
            ),
            Text((cameraScanResult == null)
                ? 'Nomor plat kendaraan : belum ada'
                : 'Nomor plat kendaraan : $cameraScanResult'),
            if (cameraScanResult != null)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PengembalianPage(
                                plat: cameraScanResult,
                              )));
                },
                child: const Text('Lanjut'),
              ),
          ],
        ),
      ),
    );
  }
}
