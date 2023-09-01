import 'package:flutter/material.dart';
import 'package:intventory/features/shared/shared.dart';

class ConfigurationsScreen extends StatelessWidget {
  const ConfigurationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text("Configuraciones"),
      ),
      body: const Center(child: Text("configuraciones")),
    );
  }
}
