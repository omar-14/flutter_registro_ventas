import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final bool hasCancel;
  final String contentCancel;
  final String contentConfirm;

  const CustomDialog(
      {super.key,
      required this.title,
      required this.content,
      this.hasCancel = false,
      this.contentCancel = "Cancelar",
      this.contentConfirm = "Confirmar"});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        hasCancel
            ? TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(contentCancel),
              )
            : const SizedBox(),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(contentConfirm),
        ),
      ],
    );
  }
}
