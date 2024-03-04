import 'package:coffe_shop/data_mangement/shoping_cart_mangement.dart';
import 'package:coffe_shop/models/cart_item_model.dart';
import 'package:coffe_shop/screens/dirink_screen.dart';
import 'package:coffe_shop/screens/home_screen.dart';
import 'package:coffe_shop/utils/costant.dart';
import 'package:coffe_shop/widgets/button_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatefulWidget {
  static String routeName = "/shoping_cart";
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final controller = PageController();

  @override
  void initState() {
    controller.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ShopingCartTopBar(
              originalContext: context,
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            bottom: 0,
            child: PageView(
              controller: controller,
              children: const [
                TotalPriceAndItemsWidget(),
                Column(
                  children: [],
                )
              ],
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ButtomNavigationBar(
                m: MediaQuery.of(context),
                activeIcon: "shoping_cart",
              )),
          Positioned(
              left: 40,
              right: 40,
              bottom: 100,
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffC67C4E),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue  ",
                        style:
                            GoogleFonts.sora(fontSize: 22, color: Colors.white),
                      ),
                      const Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                        size: 22,
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    ));
  }
}

class TotalPriceAndItemsWidget extends StatelessWidget {
  const TotalPriceAndItemsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: pageSideMargin(context), vertical: 20),
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: const TotalPriceWidget()),
              Container(
                height: 1,
                margin: const EdgeInsets.only(top: 30, bottom: 0),
                width: MediaQuery.of(context).size.width,
                color: const Color(0xffF4F4F4),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Your items : ",
                    style: GoogleFonts.sora(
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              const ShopingCartItemsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class TotalPriceWidget extends StatelessWidget {
  const TotalPriceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopingCart>(builder: (context, sp, c) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Total Price ",
            style:
                GoogleFonts.sora(fontSize: 24, color: const Color(0xff2F2D2C)),
          ),
          Text(
            "${sp.totalPrice.toStringAsFixed(2)} \$",
            style: GoogleFonts.sora(
                fontSize: 24,
                color: const Color(0xff2F2D2C),
                fontWeight: FontWeight.bold),
          ),
        ],
      );
    });
  }
}

class ShopingCartItemsWidget extends StatelessWidget {
  const ShopingCartItemsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 180),
      child: Consumer<ShopingCart>(builder: (context, value, child) {
        return value.getCartItems.isEmpty
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "there is no items please add some and come back",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sora(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Column(
                children: [
                  ...value.getCartItems.map((e) {
                    return CartItemWidget(
                      cartItem: e,
                    );
                  })
                ],
              );
      }),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItemModel cartItem;
  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(DrinkScreen.routeName,
                      arguments: {"id": cartItem.product.id});
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    width: 54,
                    height: 54,
                    image: AssetImage(".${cartItem.product.images[0]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(DrinkScreen.routeName,
                            arguments: {"id": cartItem.product.id});
                      },
                      child: Text(
                        cartItem.product.name,
                        style: GoogleFonts.sora(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff2f2d2c)),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Size : ${cartItem.sizePrice.size}",
                          style: GoogleFonts.sora(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff9B9B9B)),
                        ),
                        Text(
                          ' / Price : ${cartItem.sizePrice.price} \$',
                          style: GoogleFonts.sora(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff9B9B9B)),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 28,
                height: 28,
                child: IconButton(
                    alignment: Alignment.center,
                    style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        shape: const CircleBorder(
                            side: BorderSide(
                                color: Color(0xffAAADB0), width: .5))),
                    onPressed: () {
                      Provider.of<ShopingCart>(context, listen: false)
                          .addOrUpdateQuantityToItem(
                              product: cartItem.product,
                              quantity: -1,
                              sp: cartItem.sizePrice);
                    },
                    icon: Container(
                      width: 12,
                      height: 1,
                      color: Colors.black,
                    )),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text('${cartItem.quantity}')),
              SizedBox(
                width: 26,
                height: 26,
                child: IconButton(
                    alignment: Alignment.center,
                    style: IconButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        shape: const CircleBorder(
                            side: BorderSide(
                                color: Color(0xffAAADB0), width: .5))),
                    onPressed: () {
                      Provider.of<ShopingCart>(context, listen: false)
                          .addOrUpdateQuantityToItem(
                              product: cartItem.product,
                              quantity: 1,
                              sp: cartItem.sizePrice);
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 20,
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ShopingCartTopBar extends StatelessWidget {
  final BuildContext originalContext;
  const ShopingCartTopBar({
    super.key,
    required this.originalContext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          Expanded(
            child: Center(
              child: Text(
                "Shopping  cart",
                style: GoogleFonts.sora(
                    fontSize: 20, color: const Color(0xff2F2D2C)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
