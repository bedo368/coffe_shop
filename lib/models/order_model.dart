import 'package:coffe_shop/models/order_item.dart';

class OrderModel {
  final String id;
  List<OrderItemModel> itemLsit;
  double totalPrice;
  String state;
  String deliverMethod;
  String address;
  String note;
  String phoneNumber;
  OrderModel(
      {required this.id,
      required this.itemLsit,
      required this.totalPrice,
      required this.state,
      required this.deliverMethod,
      required this.address,
      this.note = "",
      required this.phoneNumber}) {
    // Calculate total price automatically based on items list
    totalPrice = itemLsit.fold(
        0, (prev, item) => prev + (item.quantity * item.sizePrice.price));
  }
  void updateOrderState(String newState) {
    state = newState;
  }
}
