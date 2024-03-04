import 'package:coffe_shop/data_mangement/product_mangement.dart';
import 'package:coffe_shop/data_mangement/shoping_cart_mangement.dart';
import 'package:coffe_shop/screens/dirink_screen.dart';
import 'package:coffe_shop/screens/home_screen.dart';
import 'package:coffe_shop/screens/onboarding_screen.dart';
import 'package:coffe_shop/screens/shoping_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String typo = "drink";

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductMangement()),
        ChangeNotifierProvider(create: ((context) => ShopingCart())),
      ],
      child: MaterialApp(
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          OnBoaedingScreen.routeName: (context) => const OnBoaedingScreen(),
          DrinkScreen.routeName: (context) => DrinkScreen(),
          ShoppingCartScreen.routeName: (context) => const ShoppingCartScreen()
        },
      ),
    );
  }
}
