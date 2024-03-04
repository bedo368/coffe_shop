import 'package:coffe_shop/screens/home_screen.dart';
import 'package:coffe_shop/screens/shoping_cart_screen.dart';
import 'package:flutter/material.dart';

class ButtomNavigationBar extends StatelessWidget {
  final String activeIcon;
  const ButtomNavigationBar(
      {super.key, required this.m, required this.activeIcon});

  final MediaQueryData m;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50),
      width: m.size.width,
      height: 80,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
          onTap: () {
            if (activeIcon != "home") {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            }
          },
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Icon(
                  Icons.home_filled,
                  color: activeIcon == "home"
                      ? const Color(0xffC67C4E)
                      : const Color(0xff8D8D8D),
                  size: 30,
                ),
                activeIcon == "home"
                    ? Container(
                        margin: const EdgeInsets.all(5),
                        width: 18,
                        height: 10,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color(0xffC67C4E),
                              Color(0xffEDAB81),
                            ]),
                            borderRadius: BorderRadius.circular(5)),
                      )
                    : Container()
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Icon(
                  Icons.favorite,
                  color: activeIcon == "favorite"
                      ? const Color(0xffC67C4E)
                      : const Color(0xff8D8D8D),
                  size: 30,
                ),
                activeIcon == "favorite"
                    ? Container(
                        margin: const EdgeInsets.all(5),
                        width: 18,
                        height: 10,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color(0xffC67C4E),
                              Color(0xffEDAB81),
                            ]),
                            borderRadius: BorderRadius.circular(5)),
                      )
                    : Container()
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            if (activeIcon != "shoping_cart") {
              Navigator.of(context)
                  .pushReplacementNamed(ShoppingCartScreen.routeName);
            }
          },
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Icon(
                  Icons.shopping_bag,
                  color: activeIcon == "shoping_cart"
                      ? const Color(0xffC67C4E)
                      : const Color(0xff8D8D8D),
                  size: 30,
                ),
                activeIcon == "shoping_cart"
                    ? Container(
                        margin: const EdgeInsets.all(5),
                        width: 18,
                        height: 10,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color(0xffC67C4E),
                              Color(0xffEDAB81),
                            ]),
                            borderRadius: BorderRadius.circular(5)),
                      )
                    : Container()
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Icon(
                  Icons.notifications,
                  color: activeIcon == "notification"
                      ? const Color(0xffC67C4E)
                      : const Color(0xff8D8D8D),
                  size: 30,
                ),
                activeIcon == "notification"
                    ? Container(
                        margin: const EdgeInsets.all(5),
                        width: 18,
                        height: 10,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color(0xffC67C4E),
                              Color(0xffEDAB81),
                            ]),
                            borderRadius: BorderRadius.circular(5)),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
