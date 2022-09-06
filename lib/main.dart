import 'package:bitcoin_ticker/screens/price_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: const Color(0xff19AC6F),
          scaffoldBackgroundColor: const Color(0xff181828)),
      home: PriceScreen(),
    );
  }
}
