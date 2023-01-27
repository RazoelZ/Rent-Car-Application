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
                String? cameraScanResult = await scanner.scan();
                print(cameraScanResult);
              },
              child: const Text('Scan'),
            ),
            ElevatedButton(
                onPressed: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PengembalianPage()),
                  );
                }),
                child: Text('Pengembalian')),
            ElevatedButton(
                onPressed: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => foto()),
                  );
                }),
                child: Text("Ke foto yuk"))
          ],
        ),
      ),
    );
  }
}
