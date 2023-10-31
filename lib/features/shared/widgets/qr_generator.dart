import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/inventory/presentation/providers/providers.dart';
// import 'package:qr_code_generator/styles.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:go_router/go_router.dart';

class QRGenerator extends ConsumerStatefulWidget {
  final String keyProduct;
  final String idProduct;
  const QRGenerator(
      {super.key, required this.keyProduct, required this.idProduct});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<QRGenerator> {
  // final String keyProduct;
  final GlobalKey _qrkey = GlobalKey();
  bool dirExists = false;
  dynamic externalDir = '/storage/emulated/0/Download/Qr_code';

  // _MainPageState({required this.keyProduct});

  Future<void> _captureAndSavePng() async {
    try {
      RenderRepaintBoundary boundary =
          _qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);

      // //Drawing White Background because Qr Code is Black
      final whitePaint = Paint()
        ..color = const Color.fromARGB(255, 255, 255, 255);
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder,
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()));
      canvas.drawRect(
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
          whitePaint);
      canvas.drawImage(image, Offset.zero, Paint());
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);
      ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      //Check for duplicate file name to avoid Override
      String fileName = 'qr_code';
      int i = 1;
      while (await File('$externalDir/$fileName.png').exists()) {
        fileName = 'qr_code_$i';
        i++;
      }

      // Check if Directory Path exists or not
      dirExists = await File(externalDir).exists();
      //if not then create the path
      if (!dirExists) {
        await Directory(externalDir).create(recursive: true);
        dirExists = true;
      }

      final file = await File('$externalDir/$fileName.png').create();
      await file.writeAsBytes(pngBytes);

      if (!mounted) return;
      final productState = ref.read(productProvider(widget.idProduct));

      final formProvider =
          ref.read(productFormProvider(productState.product!).notifier);

      formProvider.onKeyChanged(widget.keyProduct);

      formProvider.onFormSubmit().then((value) {
        if (!value) return;

        const snackBar = SnackBar(content: Text('QR Guardado'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        context.go("/inventory");
      });
    } catch (e) {
      if (!mounted) return;
      const snackBar = SnackBar(content: Text('Ocurrio un Error al guardar'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
            child: RepaintBoundary(
              key: _qrkey,
              child: QrImageView(
                data: widget.keyProduct,
                version: QrVersions.auto,
                size: 250.0,
                gapless: true,
                errorStateBuilder: (ctx, err) {
                  return const Center(
                    child: Text(
                      'Paso un error al crearse el QR',
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
          ),
          FilledButton(
            onPressed: _captureAndSavePng,
            child: const Text(
              'Guardar QR',
            ),
          ),
        ],
      )),
    );
  }
}
