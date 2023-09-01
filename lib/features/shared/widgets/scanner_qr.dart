import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScannerQr extends StatelessWidget {
  const ScannerQr({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text("Scanner"),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: const Icon(Icons.filter_center_focus),
        onPressed: () async {
          String barcodeScanRes;
          try {
            barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                '#ff6666', 'Cancel', true, ScanMode.QR);
            print(barcodeScanRes);
          } on PlatformException {
            barcodeScanRes = 'Failed to get platform version.';
          }
        },
      ),
    );
  }
}
