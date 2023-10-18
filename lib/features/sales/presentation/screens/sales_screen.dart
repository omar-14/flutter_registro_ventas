import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/sales/presentation/providers/providers.dart';
import 'package:intventory/features/sales/presentation/widgets/widgets.dart';
import 'package:intventory/features/shared/shared.dart';
import 'package:go_router/go_router.dart';

class SalesScreen extends ConsumerWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text("Ventas"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await ref.read(salesProvider.notifier).createSale().then((value) {
            context.push("/sales/${value.id}");
          });
        },
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

class _SalesViewState extends ConsumerState<_SalesView> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if ((scrollController.position.pixels + 100) <=
          scrollController.position.maxScrollExtent) {
        ref.watch(salesProvider.notifier).loadNextPage();
      }
    });
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

        return CardSales(
          sale: sale,
        );
      },
    );
  }
}
