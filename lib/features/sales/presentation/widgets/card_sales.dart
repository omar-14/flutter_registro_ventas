import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intventory/features/sales/domain/domain.dart';
import 'package:go_router/go_router.dart';

class CardSales extends StatelessWidget {
  final Sale sale;
  const CardSales({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        child: ListTile(
          title: Row(
            children: [
              const Text("Fecha: ", style: textStyle),
              Text(DateFormat('dd-MM-yyyy:hh:mm:ss')
                  .format(sale.createdAt!.toLocal())),
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
              ),
              // Text(sale)
            ],
          ),
          onTap: () {
            context.push("/sales/${sale.id}");
          },
          trailing: const Icon(Icons.keyboard_arrow_right_outlined),
        ),
      ),
    );
  }
}
