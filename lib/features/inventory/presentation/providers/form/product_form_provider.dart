// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:intventory/features/inventory/domain/domain.dart';
import 'package:intventory/features/shared/shared.dart';
import '../products_provider.dart';

final productFormProvider = StateNotifierProvider.autoDispose
    .family<ProductFormNotifier, ProductFormState, Product>((ref, product) {
  final creareUpdateCallback =
      ref.watch(productsProvider.notifier).createOrUpdateProduct;

  return ProductFormNotifier(
      product: product, onSubmitCallback: creareUpdateCallback);
});

class ProductFormNotifier extends StateNotifier<ProductFormState> {
  final Future<bool> Function(Map<String, dynamic> productLike)?
      onSubmitCallback;

  ProductFormNotifier({this.onSubmitCallback, required Product product})
      : super(ProductFormState(
          id: product.id,
          nameProduct: NameProduct.dirty(product.nameProduct),
          key: Key.dirty(product.key),
          brand: Brand.dirty(product.brand),
          publicPrice: Price.dirty(product.publicPrice),
          originalPrice: OriginalPrice.dirty(product.originalPrice),
          createdBy: CreatedBy.dirty(product.createdBy),
          productProfit: Profit.dirty(product.productProfit),
          productType: ProductType.dirty(product.productType),
          stock: Stock.dirty(product.stock),
        ));

  Future<bool> onFormSubmit() async {
    _touchEverything();

    if (!state.isFormValid) return false;

    if (onSubmitCallback == null) return false;

    final productLike = {
      // 'id': (state.id == "0") ? null : state.id,
      'key': state.key.value == "" ? "0" : state.key.value,
      'name': state.nameProduct.value,
      'brand': state.brand.value,
      'public_unit_price': state.publicPrice.value,
      'original_unit_price': state.originalPrice.value,
      'created_by': state.createdBy.value,
      'product_profit_percentage': state.productProfit.value,
      'product_type': state.productType.value,
      'is_season_product': false,
      'stock': state.stock.value,
    };

    if (state.id != null) {
      productLike["id"] = state.id.toString();
    }

    // print(productLike);

    try {
      return await onSubmitCallback!(productLike);
    } catch (e) {
      return false;
    }
  }

  void _touchEverything() {
    state = state.copyWith(
        isFormValid: Formz.validate([
      NameProduct.dirty(state.nameProduct.value),
      Key.dirty(state.key.value),
      Brand.dirty(state.brand.value),
      Price.dirty(state.publicPrice.value),
      OriginalPrice.dirty(state.originalPrice.value),
      CreatedBy.dirty(state.createdBy.value),
      Profit.dirty(state.productProfit.value),
      ProductType.dirty(state.productType.value),
      Stock.dirty(state.stock.value),
    ]));
  }

  // void updateProductImage(String path) {
  //   state = state.copyWith(images: [...state.images, path]);
  // }

  void onNameProductChanged(String value) {
    state = state.copyWith(
        nameProduct: NameProduct.dirty(value),
        isFormValid: Formz.validate([
          NameProduct.dirty(value),
          Key.dirty(state.key.value),
          Brand.dirty(state.brand.value),
          Price.dirty(state.publicPrice.value),
          OriginalPrice.dirty(state.originalPrice.value),
          CreatedBy.dirty(state.createdBy.value),
          Profit.dirty(state.productProfit.value),
          ProductType.dirty(state.productType.value),
          Stock.dirty(state.stock.value),
        ]));
  }

  void onBrandChanged(String value) {
    state = state.copyWith(
        brand: Brand.dirty(value),
        isFormValid: Formz.validate([
          Brand.dirty(value),
          NameProduct.dirty(state.nameProduct.value),
          Key.dirty(state.key.value),
          Price.dirty(state.publicPrice.value),
          OriginalPrice.dirty(state.originalPrice.value),
          CreatedBy.dirty(state.createdBy.value),
          Profit.dirty(state.productProfit.value),
          ProductType.dirty(state.productType.value),
          Stock.dirty(state.stock.value),
        ]));
  }

  void onPriceChanged(String value) {
    state = state.copyWith(
        publicPrice: Price.dirty(value),
        isFormValid: Formz.validate([
          Brand.dirty(state.brand.value),
          NameProduct.dirty(state.nameProduct.value),
          Key.dirty(state.key.value),
          Price.dirty(value),
          OriginalPrice.dirty(state.originalPrice.value),
          CreatedBy.dirty(state.createdBy.value),
          Profit.dirty(state.productProfit.value),
          ProductType.dirty(state.productType.value),
          Stock.dirty(state.stock.value),
        ]));
  }

  void onOriginalPriceChanged(String value) {
    state = state.copyWith(
        originalPrice: OriginalPrice.dirty(value),
        isFormValid: Formz.validate([
          NameProduct.dirty(state.nameProduct.value),
          Key.dirty(state.key.value),
          Brand.dirty(state.brand.value),
          Price.dirty(state.publicPrice.value),
          OriginalPrice.dirty(value),
          CreatedBy.dirty(state.createdBy.value),
          Profit.dirty(state.productProfit.value),
          ProductType.dirty(state.productType.value),
          Stock.dirty(state.stock.value),
        ]));
  }

  void onProductProfitChanged(String value) {
    state = state.copyWith(
        productProfit: Profit.dirty(value),
        isFormValid: Formz.validate([
          NameProduct.dirty(state.nameProduct.value),
          Key.dirty(state.key.value),
          Brand.dirty(state.brand.value),
          Price.dirty(state.publicPrice.value),
          OriginalPrice.dirty(state.originalPrice.value),
          CreatedBy.dirty(state.createdBy.value),
          Profit.dirty(value),
          ProductType.dirty(state.productType.value),
          Stock.dirty(state.stock.value),
        ]));
  }

  void onProductTypeChanged(String value) {
    state = state.copyWith(
        productType: ProductType.dirty(value),
        isFormValid: Formz.validate([
          NameProduct.dirty(state.nameProduct.value),
          Key.dirty(state.key.value),
          Brand.dirty(state.brand.value),
          Price.dirty(state.publicPrice.value),
          OriginalPrice.dirty(state.originalPrice.value),
          CreatedBy.dirty(state.createdBy.value),
          Profit.dirty(state.productProfit.value),
          ProductType.dirty(value),
          Stock.dirty(state.stock.value),
        ]));
  }

  void onStockChanged(int value) {
    state = state.copyWith(
        stock: Stock.dirty(value),
        isFormValid: Formz.validate([
          NameProduct.dirty(state.nameProduct.value),
          Key.dirty(state.key.value),
          Brand.dirty(state.brand.value),
          Price.dirty(state.publicPrice.value),
          OriginalPrice.dirty(state.originalPrice.value),
          CreatedBy.dirty(state.createdBy.value),
          Profit.dirty(state.productProfit.value),
          ProductType.dirty(state.productType.value),
          Stock.dirty(value),
        ]));
  }

  void onKeyChanged(String value) {
    state = state.copyWith(
        key: Key.dirty(value),
        isFormValid: Formz.validate([
          NameProduct.dirty(state.nameProduct.value),
          Key.dirty(value),
          Brand.dirty(state.brand.value),
          Price.dirty(state.publicPrice.value),
          OriginalPrice.dirty(state.originalPrice.value),
          CreatedBy.dirty(state.createdBy.value),
          Profit.dirty(state.productProfit.value),
          ProductType.dirty(state.productType.value),
          Stock.dirty(state.stock.value),
        ]));
  }

  // void onSizeChanged(List<String> sizes) {
  //   state = state.copyWith(sizes: sizes);
  // }

  // void onGenderChanged(String gener) {
  //   state = state.copyWith(gender: gener);
  // }

  // void onDescriptionChanged(String description) {
  //   state = state.copyWith(description: description);
  // }

  // void onTagsChanged(String tags) {
  //   state = state.copyWith(tags: tags);
  // }
}

class ProductFormState {
  final bool isFormValid;
  final String? id;
  final NameProduct nameProduct;
  final Key key;
  final Brand brand;
  final Price publicPrice;
  final OriginalPrice originalPrice;
  final CreatedBy createdBy;
  final Profit productProfit;
  final ProductType productType;
  final Stock stock;
  // final List<String> images;

  ProductFormState({
    this.isFormValid = false,
    this.id,
    this.nameProduct = const NameProduct.dirty(""),
    this.key = const Key.dirty(""),
    this.brand = const Brand.dirty(""),
    this.publicPrice = const Price.dirty(""),
    this.originalPrice = const OriginalPrice.dirty(""),
    this.stock = const Stock.dirty(0),
    this.createdBy = const CreatedBy.dirty(""),
    this.productProfit = const Profit.dirty(""),
    this.productType = const ProductType.dirty(""),
  });

  ProductFormState copyWith({
    bool? isFormValid,
    String? id,
    NameProduct? nameProduct,
    Key? key,
    Brand? brand,
    Price? publicPrice,
    OriginalPrice? originalPrice,
    CreatedBy? createdBy,
    Profit? productProfit,
    ProductType? productType,
    Stock? stock,
  }) =>
      ProductFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        nameProduct: nameProduct ?? this.nameProduct,
        key: key ?? this.key,
        brand: brand ?? this.brand,
        publicPrice: publicPrice ?? this.publicPrice,
        originalPrice: originalPrice ?? this.originalPrice,
        createdBy: createdBy ?? this.createdBy,
        productProfit: productProfit ?? this.productProfit,
        productType: productType ?? this.productType,
        stock: stock ?? this.stock,
      );
}
