import 'package:flutter/material.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:intventory/features/sales/domain/domain.dart';

class CardItemDetail extends StatelessWidget {
  final Product product;
  final DetailsSale detail;
  final void Function()? onTap;
  const CardItemDetail(
      {super.key,
      required this.product,
      required this.detail,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
    const textSKUStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 10);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: Card(
        color: Colors.indigo[300],
        child: ListTile(
          onTap: onTap,
          trailing: const Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.black,
          ),
          title: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${product.nameProduct} - ${product.brand}",
                  style: textStyle,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.productType,
                  style: textStyle,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.key.isEmpty ? "N/A" : product.key,
                  style: textSKUStyle,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Precio unitario: ",
                    style: textStyle,
                  ),
                  Text(detail.subTotal),
                  const SizedBox(width: 10),
                  const Text(
                    "Cantidad: ",
                    style: textStyle,
                  ),
                  Text(detail.productQuantity.toString().split(".")[0]),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Subtotal: ",
                    style: textStyle,
                  ),
                  Text(
                      "${double.parse(detail.subTotal) * double.parse(detail.productQuantity)}"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
