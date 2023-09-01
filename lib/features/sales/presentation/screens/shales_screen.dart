import 'package:flutter/material.dart';
import 'package:intventory/features/shared/shared.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text("Ventas"),
      ),
      body: const Center(child: Text("ventas")),
    );
  }
}
