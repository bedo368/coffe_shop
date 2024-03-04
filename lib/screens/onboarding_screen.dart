import 'package:coffe_shop/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoaedingScreen extends StatelessWidget {
  static String routeName = "/onboarding";
  const OnBoaedingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var m = MediaQuery.of(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 40),
        width: m.size.width,
        height: m.size.height,
        decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
                image: AssetImage(
                  "./assets/onboarding.png",
                ))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: m.size.width * .8,
                child: Text(
                  "Coffe so good Your taste buds will love it ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sora(color: Colors.white, fontSize: 34),
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  width: m.size.width * .8,
                  child: Text(
                      "the best grain , the finest roast , the powerful flavor ",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sora(
                        fontSize: 14,
                        color: const Color(0xffa9a9a9),
                      ))),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      fixedSize: Size(m.size.width * .8, 50),
                      maximumSize: const Size(400, 50),
                      backgroundColor: const Color(0xffc67c4e)),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, HomeScreen.routeName);
                  },
                  child: Text(
                    "Get Started ",
                    style: GoogleFonts.sora(fontSize: 16, color: Colors.white),
                  ))
            ]),
      ),
    );
  }
}
