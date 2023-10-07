import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';
import 'package:intventory/features/shared/shared.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push("/product/new"),
        label: const Text("Crear Venta"),
        icon: const Icon(Icons.add),
      ),
      body: const _SalesView(),
    );
  }
}

class _SalesView extends ConsumerStatefulWidget {
  const _SalesView();

  @override
  _SalesViewState createState() => _SalesViewState();
}

class _SalesViewState extends ConsumerState {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    // scrollController.addListener(() {
    //   if ((scrollController.position.pixels + 100) <= scrollController.position.maxScrollExtent) {

    //   }
    // });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final salesState = ref.watch(salesProvider);

    return ListView.builder(
      itemCount: salesState.sales.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        final sale = salesState.sales[index];
        const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListTile(
            title: Row(
              children: [
                const Text("Fecha: ", style: textStyle),
                Text(DateFormat('dd-MM-yyyy:hh:mm:ss')
                    .format(sale.createdAt.toLocal())),
              ],
            ),
            subtitle: Row(
              children: [
                const Text("Total: ", style: textStyle),
                Text(sale.total.toString()),
                const SizedBox(
                  width: 20,
                ),
                const Text("Estatus: ", style: textStyle),
                Text(
                  sale.isCompleted ? "Completada" : "Incompleta",
                  style: TextStyle(
                      color: sale.isCompleted
                          ? Colors.greenAccent
                          : Colors.redAccent),
                )
              ],
            ),
            onTap: () {
              context.push("/sales/${sale.id}");
            },
            trailing: const Icon(Icons.keyboard_arrow_right_outlined),
          ),
        );
      },
    );
  }
}
