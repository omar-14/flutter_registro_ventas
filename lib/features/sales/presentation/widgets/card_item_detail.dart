import 'package:flutter/material.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:intventory/features/sales/domain/domain.dart';
// import 'package:intventory/features/sales/presentation/widgets/widgets.dart';

class CardItemDetail extends StatelessWidget {
  final Product? product;
  final DetailsSale detail;
  const CardItemDetail(
      {super.key, required this.product, required this.detail});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: Card(
        color: Colors.indigo[300],
        child: ListTile(
          onTap: () {
            // showModalBottomSheet(
            //   context: context,
            //   builder: (builder) {
            //     return FormAddProduct(
            //       product: product,
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //     );
            //   },
            // );
          },
          trailing: const Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.black,
          ),
          title: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${product?.nameProduct ?? ""} - ${product?.brand ?? ""}",
                  style: textStyle,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Subtotal: ",
                    style: textStyle,
                  ),
                  Text(detail.subTotal),
                  const SizedBox(width: 10),
                  const Text(
                    "Cantidad: ",
                    style: textStyle,
                  ),
                  Text(detail.productQuantity.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
