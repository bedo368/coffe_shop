import 'dart:async';

import 'package:coffe_shop/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OffersWedgit extends StatefulWidget {
  final List<Map<String, dynamic>> offerslist;
  const OffersWedgit({super.key, required this.offerslist});

  @override
  State<OffersWedgit> createState() => _OffersWedgitState();
}

class _OffersWedgitState extends State<OffersWedgit> {
  final controller = PageController();
  final FixedExtentScrollController fixedExtentScrollController =
      FixedExtentScrollController();

  List<Map<String, dynamic>> l = [];
  bool isLoading = false;
  @override
  void initState() {
    controller.addListener(
      () async {
        if (controller.page == l.length - 1) {
          setState(() {
            isLoading = true;
          });

          await Future.delayed(const Duration(milliseconds: 3000), () {});
          setState(() {
            l.add({
              "name": "pomo",
              "disc": "buy one get one free",
              "image": "./assets/image 8.png"
            });
          });

          setState(() {
            isLoading = false;
          });
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (l.isEmpty) {
      l = List.from(widget.offerslist);
    }

    return Stack(
      children: [
        PageView.builder(
          // scrollDirection: Axis.vertical,
          controller: controller,
          itemCount: l.length,
          itemBuilder: (context, index) {
            return OfferWidget(
                disc: l[index]["disc"],
                name: l[index]["name"],
                image: l[index]["image"]);
          },
        ),
        isLoading
            ? const Center(
                child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 5,
                    )),
              )
            : Container(),
        Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Center(
                child: Transform.translate(
              offset: const Offset(0, 20),
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: const WormEffect(
                    dotColor: Color.fromARGB(255, 197, 196, 196),
                    activeDotColor: Colors.black87),
              ),
            )))
      ],
    );
  }
}
