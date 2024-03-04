import 'package:coffe_shop/models/product_model.dart';
import 'package:flutter/material.dart';

class DrinkModel extends ChangeNotifier implements ProductModel {
  @override
  String catigory;
  @override
  final String id;
  @override
  String type;
  @override
  List<SizePrice> sizePrice;
  @override
  List<String> images;
  @override
  String name;
  @override
  String disc;
  bool? isFaivorite = false;
  @override
  Rate rate;
  @override
  List<String>? extra;

  DrinkModel(
      {required this.id,
      required this.name,
      required this.disc,
      required this.type,
      required this.sizePrice,
      required this.images,
      this.isFaivorite,
      required this.catigory,
      this.rate = const Rate(),
      this.extra});

  double getPriceBySize(String size) {
    for (var e in sizePrice) {
      if (e.size == size) {
        return e.price;
      }
    }
    return sizePrice[1].price;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
