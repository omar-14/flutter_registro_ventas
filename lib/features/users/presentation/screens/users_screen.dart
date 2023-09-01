import 'package:flutter/material.dart';
import 'package:intventory/features/shared/shared.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text("Usuarios"),
      ),
      body: const Center(child: Text("usuarios")),
    );
  }
}
