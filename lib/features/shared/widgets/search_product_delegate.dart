import 'package:flutter/widgets.dart';
import 'package:intventory/features/inventory/domain/domain.dart';

typedef SearchProductsCallBack = Future<List<Product>> Function(String query);

class SearchProductDelegate extends StatelessWidget {
  const SearchProductDelegate({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
