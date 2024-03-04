import 'package:coffe_shop/models/cart_item_model.dart';
import 'package:coffe_shop/models/product_model.dart';
import 'package:flutter/material.dart';

class ShopingCart with ChangeNotifier {
  final Map<String, CartItemModel> _itemLsit = {};
  String _deliverMethod = "";
  int get itemsCount => _itemLsit.length;
  double get totalPrice => _itemLsit.values
      .fold(0, (prev, item) => prev + (item.quantity * item.sizePrice.price));

  void addOrUpdateQuantityToItem(
      {required ProductModel product,
      required int quantity,
      required SizePrice sp}) {
    final customId = _createIdForCartItem(id: product.id, sp: sp);

    if (_itemLsit.containsKey(customId)) {
      if (_itemLsit[customId]!.quantity + quantity == 0) {
        _itemLsit.remove(customId);
        notifyListeners();
        return;
      }
      _itemLsit[customId]!.updateItemQuantity(quantity);
    } else {
      _itemLsit.putIfAbsent(
          customId,
          () => CartItemModel(
                id: _createIdForCartItem(id: product.id, sp: sp),
                quantity: quantity,
                product: product,
                sizePrice: sp,
              ));
    }

    notifyListeners();
  }

  void updateDeliverMethod(String method) {
    _deliverMethod = method;
    notifyListeners();
  }

  Future<void> placeOrderAndEmptyTheCart() async {
    _itemLsit.clear();
    notifyListeners();
  }

  String _createIdForCartItem({required String id, required SizePrice sp}) {
    return "${id}_${sp.size}";
  }

  String get deliverMethod => _deliverMethod;
  List<CartItemModel> get getCartItems => _itemLsit.values.toList();
}
