import 'package:coffe_shop/models/product_model.dart';

class OrderItemModel {
  final String id;
  final int quantity;
  final ProductModel product;
  final SizePrice sizePrice;
  final double? discount;

  OrderItemModel(
      {required this.id,
      required this.quantity,
      required this.product,
      required this.sizePrice,
      this.discount = 0});
}
