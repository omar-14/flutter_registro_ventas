// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String textButton;
  final void Function()? onPressed;

  const CustomButton({
    Key? key,
    required this.textButton,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
          onPressed: onPressed,
          child: Text(
            textButton,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
