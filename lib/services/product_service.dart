import 'dart:async';

class ProductService {
  Future<List<dynamic>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 2));

    return productList;
  }
}

List<Map<String, dynamic>> productList = [
  {
    "id": "p1",
    "name": "coffe late",
    "disc":
        "this is the best coffe the human made ever this is the best coffe the human made everthis is the best coffe the human made everthis is the best coffe the human made everthis is the best coffe the human made everthis is the best coffe the human made everthis is the best coffe the human made everthis is the best coffe the human made ever ",
    "sizePrice": {"Small": 10.5},
    'images': [
      "/assets/black_coffee.webp",
      "/assets/capichino.png",
    ],
    "type": "drink",
    "catigory": "coffe",
    "extra": [
      "with choclete",
      "extra coffee",
      "extra coffee",
      "extra coffee",
      "extra coffee",
      "extra coffee",
      "extra coffee",
      "extra coffee"
    ]
  },
  {
    "id": "p2",
    "name": "coffe late",
    "disc":
        "this is the best coffe the human made ever fafads fasdf dasf adsfasdfadsf ",
    "sizePrice": {"Small": 10, "meduim": 15.3},
    'images': ["/assets/capichino.png", "/assets/black_coffee.webp"],
    "type": "drink",
    "catigory": "coffe",
  },
  {
    "id": "p3",
    "name": "coca",
    "disc": "this is the best coffe the human made ever ",
    "sizePrice": {"Small": 10.5, "meduim": 15.3, "large": 1.9},
    'images': ["/assets/coca.jpg", "/assets/black_coffee.webp"],
    "type": "drink",
    "catigory": "coffe",
  },
  {
    "id": "p4",
    "name": "black coffe",
    "disc": "this is the best coffe the human made ever ",
    "sizePrice": {"Small": 10.5, "meduim": 15.3, "large": 1.9},
    'images': ["/assets/capichino.png", "/assets/black_coffee.webp"],
    "type": "drink",
    "catigory": "coffe",
  },
];
