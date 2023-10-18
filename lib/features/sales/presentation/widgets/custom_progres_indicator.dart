import 'package:flutter/material.dart';

class CustomProgresIndicator extends StatelessWidget {
  const CustomProgresIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 2,
          ),
          Text("Cargando....")
        ],
      ),
    );
  }
}
