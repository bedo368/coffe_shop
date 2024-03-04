import 'package:auto_size_text/auto_size_text.dart';
import 'package:coffe_shop/data_mangement/product_mangement.dart';
import 'package:coffe_shop/data_mangement/shoping_cart_mangement.dart';
import 'package:coffe_shop/models/product_model.dart';
import 'package:coffe_shop/screens/dirink_screen.dart';
import 'package:coffe_shop/services/product_service.dart';
import 'package:coffe_shop/widgets/button_navigation_bar.dart';
import 'package:coffe_shop/widgets/offers_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

const offerslist2 = [
  {
    "name": "pomo",
    "disc": "buy one get one free",
    "image": "./assets/image 8.png"
  },
  {
    "name": "coca",
    "disc": "buy one get one two free ",
    "image": "./assets/coca.jpg"
  },
  {
    "name": "Black coffee",
    "disc": "free on firday if you order any bills  more than \$50",
    "image": "./assets/black_coffee.webp"
  }
];

class HomeScreen extends StatefulWidget {
  static String routeName = "/";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final productsCon = Provider.of<ProductMangement>(context, listen: false);
    if (productsCon.getProductAsList.isEmpty) {
      productsCon.fetchItems().then((value) {});
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var m = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color(0xffF9F9F9),
      bottomNavigationBar: ButtomNavigationBar(
        m: m,
        activeIcon: "home",
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 600,
              // margin: EdgeInsets.only(bottom: 40),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        height: 400,
                        padding: const EdgeInsets.only(
                            top: 100, bottom: 140, left: 30, right: 30),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Color(0Xff131313),
                              Color(0xff313131),
                            ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft)),
                        child: const Column(
                          children: [
                            LocationAndImage(),
                            SearchBar(),
                          ],
                        )),
                  ),
                  Positioned(
                    top: 400,
                    left: 0,
                    right: 0,
                    child: Transform.translate(
                        offset: const Offset(0, -100),
                        child: Column(
                          children: [
                            SizedBox(
                              width: m.size.width,
                              height: 200,
                              child:
                                  const OffersWedgit(offerslist: offerslist2),
                            ),
                            const CoffeTypeSelectors(),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
          Consumer<ProductMangement>(builder: (context, c, v) {
            return c.getProductAsList.isEmpty
                ? const SliverToBoxAdapter(
                    child: Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                          strokeWidth: 4,
                        ),
                      ),
                    ),
                  )
                : SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            // childAspectRatio: 2.0 / 3,
                            mainAxisSpacing: 30),
                    itemCount: c.getProductAsList.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: ProductFactory.create(productList[index]),
                      );
                    });
          }),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Card(
        color: const Color.fromARGB(255, 255, 255, 255),
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(DrinkScreen.routeName, arguments: {
                    "id": product.id,
                  });
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image(
                      width: 300,
                      height: 200,
                      fit: BoxFit.fitWidth,
                      image: AssetImage(".${product.images[0]}")),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(
                  product.name,
                  style: GoogleFonts.sora(
                      color: const Color(0xff2F2D2C),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: 300,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: AutoSizeText(
                  (product.disc),
                  maxLines: 2,
                  style: GoogleFonts.sora(
                      color: const Color(0xff9B9B9B),
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                width: 290,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ ${product.sizePrice[0].price}',
                      style: GoogleFonts.sora(
                          color: const Color(0xff2F2D2C),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                          backgroundColor: const Color(0xffC67C4E),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        final ShopingCart sp =
                            Provider.of<ShopingCart>(context, listen: false);
                        sp.addOrUpdateQuantityToItem(
                            product: product,
                            quantity: 1,
                            sp: product.sizePrice[0]);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CoffeTypeSelectors extends StatelessWidget {
  const CoffeTypeSelectors({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(top: 30),
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CoffeTypeSelector(
              type: "Cappucino",
              isActive: true,
            ),
            CoffeTypeSelector(
              isActive: false,
              type: "Machiato ",
            ),
            CoffeTypeSelector(
              isActive: false,
              type: "Abdullah late",
            ),
            CoffeTypeSelector(
              isActive: false,
              type: "Don't try Abdullah late ",
            ),
          ],
        ),
      ),
    );
  }
}

class CoffeTypeSelector extends StatelessWidget {
  const CoffeTypeSelector({
    super.key,
    required this.type,
    required this.isActive,
  });
  final String type;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isActive ? const Color(0xffc67c4e) : Colors.white,
      ),
      child: Text(
        type,
        style: GoogleFonts.sora(
            fontSize: 14, color: isActive ? Colors.white : Colors.black),
      ),
    );
  }
}

class OfferWidget extends StatelessWidget {
  const OfferWidget(
      {super.key, required this.disc, required this.name, required this.image});

  final String name;
  final String disc;
  final String image;

  @override
  Widget build(BuildContext context) {
    var m = MediaQuery.of(context);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        width: m.size.width * .9,
        height: 200,
        // constraints: const BoxConstraints(maxHeight: 250),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
                image: AssetImage(image))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: const Color(0xffED5151),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                name,
                style: GoogleFonts.sora(fontSize: 14, color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: AutoSizeText(
                disc,
                maxLines: 2,
                style: GoogleFonts.sora(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  backgroundColor: const Color.fromARGB(167, 0, 0, 0),
                ),
              ),
            )
          ],
        ));
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(17),
            suffixIcon: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                    color: const Color(0xffC67C4E),
                    borderRadius: BorderRadius.circular(15)),
                child: const Icon(
                  Icons.linear_scale,
                  color: Colors.white,
                )),
            hintText: "Search Coffee",
            hintStyle:
                GoogleFonts.sora(color: const Color(0xff989898), fontSize: 14),
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 20, right: 5),
              child: const Icon(
                Icons.search_outlined,
                color: Colors.white,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            filled: true,
            fillColor: const Color(0xff313131)),
      ),
    );
  }
}

class LocationAndImage extends StatelessWidget {
  const LocationAndImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "location",
              style: GoogleFonts.sora(
                  color: const Color(0xffB7B7B7), fontSize: 12),
            ),
            Container(
              margin: const EdgeInsets.only(top: 3),
              child: Text(
                "Baltim , Kafer Elshikh",
                style: GoogleFonts.sora(
                    fontSize: 14, color: const Color(0xffDDDDDD)),
              ),
            )
          ],
        ),
        const Image(
            width: 44, height: 44, image: AssetImage("./assets/Image.png")),
      ],
    );
  }
}
