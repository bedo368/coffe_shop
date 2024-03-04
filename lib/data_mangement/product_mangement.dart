import 'package:coffe_shop/models/product_model.dart';
import 'package:coffe_shop/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductMangement extends ChangeNotifier {
  final Map<String, ProductModel> _items = {};
  final ProductService _ps = ProductService();

  Future<void> fetchItems() async {
    List<dynamic> templist = await _ps.fetchProducts();

    for (var element in templist) {
      _items[element["id"]] = ProductFactory.create(element);
    }

    notifyListeners();
  }

  dynamic getProduct(String id) {
    return _items[id];
  }

  List<ProductModel> get getProductAsList => _items.values.toList();
}
