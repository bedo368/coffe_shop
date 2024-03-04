import 'package:coffe_shop/data_mangement/product_mangement.dart';
import 'package:coffe_shop/data_mangement/shoping_cart_mangement.dart';
import 'package:coffe_shop/models/drink_model.dart';
import 'package:coffe_shop/models/product_model.dart';
import 'package:coffe_shop/screens/shoping_cart_screen.dart';
import 'package:coffe_shop/utils/costant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:coffe_shop/widgets/read_more_text.dart';

class DrinkScreen extends StatelessWidget {
  static String routeName = "/Drinks";
  DrinkScreen({super.key});

  final productSizeChangeNotifier = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    String id = (ModalRoute.of(context)!.settings.arguments
        as Map<String, dynamic>)['id'] as String;
    DrinkModel product = Provider.of<ProductMangement>(context).getProduct(id);
    var m = MediaQuery.of(context);
    productSizeChangeNotifier.value = product.sizePrice[0].size;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: m.size.width,
          height: m.size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const ProductAppBar(),
                    ProductImage(
                      m: m,
                      imageList: product.images,
                    ),
                    ProductTitleAndExtra(
                      m: m,
                      title: product.name,
                      extra: product.extra,
                    ),
                    Ratewidget(
                      m: m,
                      rate: product.rate,
                    ),
                    Discription(m: m, disc: product.disc),
                    product.sizePrice.length == 1
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.only(bottom: 130, top: 10),
                            child: SizeWidget(
                              passSize: (size) {
                                productSizeChangeNotifier.value = size;
                              },
                              m: m,
                              product: product,
                              activeSize: productSizeChangeNotifier.value,
                            ),
                          )
                  ],
                ),
              ),
              Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: ValueListenableBuilder(
                      valueListenable: productSizeChangeNotifier,
                      builder: (context, c, v) {
                        return ButtomNavWithPriceAndBuyButtonAndAddToCart(
                          m: m,
                          price: product.getPriceBySize(c),
                          addProductCallback: () {
                            Provider.of<ShopingCart>(context, listen: false)
                                .addOrUpdateQuantityToItem(
                                    product: product,
                                    quantity: 1,
                                    sp: product.sizePrice
                                        .where((element) => element.size == c)
                                        .first);
                          },
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtomNavWithPriceAndBuyButtonAndAddToCart extends StatefulWidget {
  final double price;
  final MediaQueryData m;
  final void Function() addProductCallback;
  const ButtomNavWithPriceAndBuyButtonAndAddToCart(
      {super.key,
      required this.m,
      required this.price,
      required this.addProductCallback});

  @override
  State<ButtomNavWithPriceAndBuyButtonAndAddToCart> createState() =>
      _ButtomNavWithPriceAndBuyButtonAndAddToCartState();
}

class _ButtomNavWithPriceAndBuyButtonAndAddToCartState
    extends State<ButtomNavWithPriceAndBuyButtonAndAddToCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: EdgeInsets.symmetric(horizontal: pageSideMargin(context)),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, -5), color: Color(0xf1e4e4e4), blurRadius: 20)
          ],
          color: Colors.white,
          border: Border.all(
              strokeAlign: BorderSide.strokeAlignInside,
              width: 1,
              color: const Color(0xffF1F1F1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Price",
                style: TextStyle(fontSize: 16, color: Color(0xff9b9b9b)),
              ),
              Text(
                "${widget.price}",
                style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xffC67C4E),
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
              height: 65,
              width: 65,
              child: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xffF1F1F1)),
                ),
                onPressed: () {
                  widget.addProductCallback();
                },
              )),
          SizedBox(
              height: 65,
              width: widget.m.size.width * .5,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xffC67C4E)),
                  ),
                  onPressed: () {
                    widget.addProductCallback();
                    Navigator.pushNamed(context, ShoppingCartScreen.routeName);
                  },
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )))
        ],
      ),
    );
  }
}

class SizeWidget extends StatefulWidget {
  final String activeSize;
  final void Function(String) passSize; // Define a callback function
  const SizeWidget(
      {super.key,
      required this.m,
      required this.product,
      required this.activeSize,
      required this.passSize});

  final MediaQueryData m;
  final DrinkModel product;

  @override
  State<SizeWidget> createState() => _SizeWidgetState();
}

class _SizeWidgetState extends State<SizeWidget> {
  late String currentActiveSize;
  @override
  void initState() {
    currentActiveSize = widget.activeSize;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: pageSideMargin(context)),
          child: Text(
            "Size",
            style: GoogleFonts.sora(
                fontSize: 16,
                color: const Color(0xff2F2D2C),
                fontWeight: FontWeight.w600),
          ),
        ),
        Container(
            width: widget.m.size.width,
            height: 40,
            margin: EdgeInsets.symmetric(
                horizontal: pageSideMargin(context), vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...widget.product.sizePrice.map(
                  (e) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          currentActiveSize = e.size;
                        });
                        widget.passSize(e.size);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: currentActiveSize == e.size
                                ? const Color(0xffC67C4E)
                                : Colors.white,
                            border: Border.all(
                                color: const Color(0xffC67C4E),
                                strokeAlign: BorderSide.strokeAlignOutside,
                                width: 1)),
                        width: widget.m.size.width * .22,
                        height: 40,
                        child: Center(
                            child: Text(
                          e.size,
                          style: TextStyle(
                              color: currentActiveSize == e.size
                                  ? Colors.white
                                  : const Color(0xff2f2d2c)),
                        )),
                      ),
                    );
                  },
                )
              ],
            )),
      ],
    );
  }
}

class Discription extends StatelessWidget {
  const Discription({
    super.key,
    required this.m,
    required this.disc,
  });

  final MediaQueryData m;
  final String disc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: pageSideMargin(context), vertical: 10),
          child: const Divider(
            height: 1,
            color: Color(0xffEAEAEA), // Customize color as needed
            thickness: 1, // Adjust thickness as needed
          ),
        ),
        Container(
          width: m.size.width,
          margin: EdgeInsets.symmetric(horizontal: pageSideMargin(context)),
          child: Text(
            "Discription",
            style: GoogleFonts.sora(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xff2f2f2c)),
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          width: m.size.width,
          margin: EdgeInsets.symmetric(horizontal: pageSideMargin(context)),
          child: ReadMoreText(
            maxLines: 3,
            text: disc,
            readmeStyle: const TextStyle(
              fontSize: 16,
              color: Color(0xffC67C4E),
              fontWeight: FontWeight.bold,
            ),
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff9B9B9B),
            ),
          ),
        )
      ],
    );
  }
}

class Ratewidget extends StatelessWidget {
  final Rate rate;
  const Ratewidget({
    super.key,
    required this.m,
    required this.rate,
  });

  final MediaQueryData m;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: pageSideMargin(context), vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.star,
                size: 25,
                color: Color(0xffFBBE21),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  "${rate.rateing}",
                  style: GoogleFonts.sora(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                child: Text(
                  "( ${rate.peopleCount} )",
                  style: GoogleFonts.sora(
                    color: const Color(0xff808080),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color(0xfff9f9f9)),
                child: const Center(
                  child: Icon(
                    Icons.coffee,
                    color: Color(0xffC67C4E),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color(0xfff9f9f9)),
                child: const Center(
                  child: Icon(
                    Icons.link,
                    color: Color(0xffC67C4E),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ProductTitleAndExtra extends StatelessWidget {
  final String title;
  final dynamic extra;
  const ProductTitleAndExtra({
    super.key,
    required this.m,
    required this.title,
    this.extra,
  });

  final MediaQueryData m;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: pageSideMargin(context), top: 20),
          width: m.size.width,
          child: Text(
            title,
            style: GoogleFonts.sora(
                fontSize: 20,
                color: const Color(0xff2f2d2c),
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.start,
          ),
        ),
        extra != null
            ? Container(
                constraints: const BoxConstraints(minHeight: 5, maxHeight: 15),
                margin: EdgeInsets.symmetric(
                    horizontal: pageSideMargin(context) + 2),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: extra!.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        if (index == 0)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            child: Text(
                              "Extra : ",
                              style: GoogleFonts.sora(
                                fontSize: 14,
                                color: const Color.fromARGB(255, 131, 130, 130),
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 1),
                          child: Text(
                            "${extra![index]} ${index < extra!.length - 1 ? "  +" : ""}",
                            style: GoogleFonts.sora(
                              fontSize: 12,
                              color: const Color(0xff9b9b9b),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            : Container(
                margin:
                    EdgeInsets.symmetric(horizontal: pageSideMargin(context)),
                child: Text(
                  "with out any addition",
                  style: GoogleFonts.sora(
                    fontSize: 12,
                    color: const Color(0xff9b9b9b),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                ),
              )
      ],
    );
  }
}

class ProductImage extends StatelessWidget {
  final List<String> imageList;
  ProductImage({
    super.key,
    required this.m,
    required this.imageList,
  });

  final MediaQueryData m;
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: m.size.width, maxHeight: 300),
      child: PageView.builder(
        controller: controller,
        itemBuilder: (context, i) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: pageSideMargin(context)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image(
                  fit: BoxFit.cover, image: AssetImage(".${imageList[i]}")),
            ),
          );
        },
        itemCount: 2,
      ),
    );
  }
}

class ProductAppBar extends StatelessWidget {
  const ProductAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 10, horizontal: MediaQuery.of(context).size.width * .045),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              color: const Color(0xff2F2D2C),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: Colors.black,
              )),
          const Text(
            "Detail",
            style: TextStyle(fontSize: 22, color: Color(0xff2F2D2C)),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border_outlined,
                size: 30,
              ))
        ],
      ),
    );
  }
}
