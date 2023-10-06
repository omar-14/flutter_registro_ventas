import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';

class QRGenerator extends StatelessWidget {
  const QRGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: QrImageView(
                data: 'Hola-es-el-qr',
                version: QrVersions.auto,
                size: 320,
                gapless: false,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {},
              child: Text('Guardar QR'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> saveQRToGallery(String data) async {
    try {
      final image = await QrPainter(
        data: data,
        version: QrVersions.auto,
        // size: 200.0,
      ).toImage(200); // Tamaño de la imagen QR
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final buffer = byteData!.buffer.asUint8List();
      await ImageGallerySaver.saveImage(Uint8List.fromList(buffer));
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
