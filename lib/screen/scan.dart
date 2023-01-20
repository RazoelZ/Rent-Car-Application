import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

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
        child: ElevatedButton(
          onPressed: () async {
            String? cameraScanResult = await scanner.scan();
            print(cameraScanResult);
          },
          child: const Text('Scan'),
        ),
      ),
    );
  }
}
