// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intventory/features/inventory/domain/domain.dart';
// import 'package:intventory/features/sales/domain/domain.dart';
// import 'package:intventory/features/sales/presentation/providers/providers.dart';
// import 'package:intventory/features/shared/widgets/widgets.dart';

// class FormProduct extends ConsumerWidget {
//   final Product product;
//   final String idSale;
//   final DetailsSale? detail;
//   final void Function()? onPressed;

//   const FormProduct(
//       {super.key,
//       required this.product,
//       this.onPressed,
//       this.detail,
//       required this.idSale});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     const textStyleLabel = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
//     const textStyleContain = TextStyle(fontSize: 20);

//     final detailSaleForm = ref.watch(detailSaleFormProvider(idSale));

//     return SizedBox(
//       height: 500, // Altura del BottomSheet
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Card(
//           // color: Colors.blueGrey[100],
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Row(children: [
//                   const Text(
//                     "Producto: ",
//                     style: textStyleLabel,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     product.nameProduct,
//                     style: textStyleContain,
//                   ),
//                 ]),
//                 Row(
//                   children: [
//                     const Text(
//                       "Marca: ",
//                       style: textStyleLabel,
//                     ),
//                     const SizedBox(width: 8),
//                     Text(product.nameProduct, style: textStyleContain),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     const Text(
//                       "Tipo: ",
//                       style: textStyleLabel,
//                     ),
//                     const SizedBox(width: 8),
//                     Text(product.nameProduct, style: textStyleContain)
//                   ],
//                 ),
//                 const SizedBox(height: 3),
//                 Row(
//                   children: [
//                     const Text(
//                       "Existencias: ",
//                       style: textStyleLabel,
//                     ),
//                     Text(product.stock.toString()),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 CustomProductField(
//                   isTopField: true,
//                   isBottomField: true,
//                   label: 'Cantidad',
//                   keyboardType:
//                       const TextInputType.numberWithOptions(decimal: true),
//                   initialValue:
//                       detail?.productQuantity.toString().split(".")[0] ?? "0",
//                   onChanged: (value) async {
//                     await ref
//                         .read(detailSaleFormProvider(idSale).notifier)
//                         .onQuantityChanged(double.tryParse(value) ?? -1);
//                   },
//                   errorMessage: detailSaleForm.isFormPosted
//                       ? detailSaleForm.quantity.errorMessage
//                       : null,
//                 ),
//                 Flexible(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           padding: const EdgeInsets.all(16.0),
//                           child: ElevatedButton(
//                             style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all(
//                                   const Color.fromARGB(255, 10, 60, 100)),
//                             ),
//                             onPressed: onPressed,
//                             child: const Text(
//                               'Guardar',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
