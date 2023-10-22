import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intventory/features/sales/domain/domain.dart';
import 'package:go_router/go_router.dart';

class CardSales extends StatelessWidget {
  final Sale sale;
  const CardSales({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    const titileStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
    const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 13);

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        child: ListTile(
          title: Row(
            children: [
              const Text("Fecha: ", style: titileStyle),
              Text(DateFormat('dd-MM-yyyy:hh:mm:ss')
                  .format(sale.createdAt!.toLocal())),
            ],
          ),
          subtitle: Column(
            children: [
              const SizedBox(height: 3),
              Row(
                children: [
                  const Text("Total: ", style: textStyle),
                  Text(sale.total.toString()),
                  const SizedBox(
                    width: 25,
                  ),
                  const Text("Items: ", style: textStyle),
                  Text(sale.numberOfProducts.toString()),
                  const SizedBox(
                    width: 25,
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Usuario: ", style: textStyle),
                  // Text(
                  //     "${sale.user?.firstName ?? ""} ${sale.user?.lastName ?? ""}"),
                  Text(sale.user?.username ?? ""),
                  const SizedBox(
                    width: 30,
                  ),
                  const Text("Estatus: ", style: titileStyle),
                  Text(
                    sale.isCompleted ? "Completada" : "Incompleta",
                    style: TextStyle(
                        color: sale.isCompleted
                            ? Colors.greenAccent
                            : Colors.redAccent),
                  ),
                ],
              ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     const Text("Estatus: ", style: titileStyle),
              //     Text(
              //       sale.isCompleted ? "Completada" : "Incompleta",
              //       style: TextStyle(
              //           color: sale.isCompleted
              //               ? Colors.greenAccent
              //               : Colors.redAccent),
              //     ),
              //   ],
              // )
            ],
          ),
          onTap: () {
            context.push("/sales/${sale.id}");
          },
          trailing: const Icon(
            Icons.keyboard_arrow_right_outlined,
            size: 20,
          ),
        ),
      ),
    );
  }
}
