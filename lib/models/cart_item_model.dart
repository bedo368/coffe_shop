import 'package:coffe_shop/models/product_model.dart';
import 'package:flutter/material.dart';

class CartItemModel with ChangeNotifier {
  final String id;
  int quantity;
  final ProductModel product;
  final double? discount;
  SizePrice sizePrice;

  CartItemModel(
      {required this.id,
      required this.quantity,
      required this.product,
      required this.sizePrice,
      this.discount = 0});

  void updateItemQuantity(int q) {
    quantity += q;
    // notifyListeners();
  }
}
