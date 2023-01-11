import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scan'),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.camera_alt),
                text: 'Scan QR Code',
              ),
              Tab(
                icon: Icon(Icons.qr_code_scanner),
                text: 'My QR Codes',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: QrImage(
                    data: 'https://www.google.com',
                    version: QrVersions.auto,
                    size: 300.0,
                  ),
                ),
                Text("Arka Joko Pranoto")
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      var text = await scanner.scan();
                    },
                    child: Text("Scan Sekarang"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
