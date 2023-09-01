import 'package:flutter/material.dart';
import 'package:intventory/features/shared/shared.dart';

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text("Lista de recomendaciones"),
      ),
      body: const Center(child: Text("recomendaciones")),
    );
  }
}
