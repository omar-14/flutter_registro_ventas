import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:animate_do/animate_do.dart';
import 'package:intventory/features/inventory/domain/domain.dart';

typedef SearchProductCallBack = Future<List<Product>> Function(String query);

class SearchProductDelegate extends SearchDelegate<Product?> {
  final SearchProductCallBack searchProducts;
  List<Product> initialProduct;

  StreamController<List<Product>> debouncedMovies =
      StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchProductDelegate(
      {required this.initialProduct, required this.searchProducts});

  @override
  String get searchFieldLabel => 'Buscar Producto';

  void _onQueryChanged(String query) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final products = await searchProducts(query);
      initialProduct = products;
      debouncedMovies.add(products);
      isLoadingStream.add(false);
    });
  }

  void clearStreams() {
    debouncedMovies.close();
  }

  Widget _buildResultsAndSuggestios() {
    return StreamBuilder(
      initialData: initialProduct,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        final product = snapshot.data ?? [];

        return ListView.builder(
          itemCount: product.length,
          itemBuilder: (context, index) => _ProductItem(
            product: product[index],
            onMovieSelected: (context, movie) {
              clearStreams();
              close(context, movie);
            },
          ),
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SizedBox(
                child: IconButton(
                    onPressed: () => query = '',
                    icon: const Icon(Icons.refresh_rounded)));
          }
          return SizedBox(
              child: IconButton(
                  onPressed: () => query = '', icon: const Icon(Icons.clear)));
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsAndSuggestios();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return _buildResultsAndSuggestios();
  }
}

class _ProductItem extends StatelessWidget {
  const _ProductItem({
    required this.product,
    required this.onMovieSelected,
  });

  final Product product;
  final Function onMovieSelected;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    // final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, product);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        child: Column(children: [
          SizedBox(
            // width: 0.7,
            child: Row(children: [
              Text(product.nameProduct, style: textStyle.titleSmall),
              const SizedBox(width: 20),

              Text(product.brand),
              const Divider(),

              // Row(
              //   children: [
              //     // Icon(
              //     //   Icons.star_half_outlined,
              //     //   color: Colors.yellow.shade800,
              //     // ),
              //     const SizedBox(
              //       width: 5,
              //     ),
              //     // Text(
              //     //   HumanFormats.number(movie.voteAverage, 1),
              //     //   style: textStyle.bodyMedium
              //     //       ?.copyWith(color: Colors.yellow.shade900),
              //     // )
              //   ],
              // )
            ]),
          )
        ]),
      ),
    );
  }
}
