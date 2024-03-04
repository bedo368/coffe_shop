import 'package:coffe_shop/models/drink_model.dart';

abstract class ProductModel {
  String get id;
  String get name;
  String get type;
  String get disc;
  Rate? get rate;
  List<SizePrice> get sizePrice;
  List<String> get images;
  String get catigory;
  List<String>? get extra;
  double? get discount;
}

class ProductFactory {
  static ProductModel create(Map<String, dynamic> product) {
    final String type = product["type"];
    if (type == "drink") {
      List<SizePrice> sp = [];
      (product["sizePrice"] as Map<String, dynamic>).forEach((key, value) {
        double? temp;
        if (value is int) {
          temp = value.toDouble();
        }
        sp.add(SizePrice(size: key, price: temp ?? value));
      });
      return DrinkModel(
          id: product["id"],
          name: product["name"],
          sizePrice: sp,
          type: product["type"],
          disc: product["disc"],
          images: product["images"],
          catigory: product["catigory"],
          extra: product["extra"],
          rate: Rate(
              peopleCount: product.containsKey("rate")
                  ? product["rate"].containsKey("peopleCount") ??
                      product["rate"]["peopleCount"]
                  : 0,
              rateing: product.containsKey("rate")
                  ? product["rate"].containsKey("rateing") ??
                      product["rate"]["rateing"]
                  : 5));
    }
    throw ArgumentError("Unknown product type: $type");
  }
}

class SizePrice {
  final String size;
  double price;
  double discount;

  SizePrice({
    required this.size,
    required this.price,
    this.discount = 0,
  });

  double get getPriceWithdiscount {
    return price - discount;
  }
}

class Rate {
  final double rateing;
  final int peopleCount;
  const Rate({this.peopleCount = 0, this.rateing = 5});
}
