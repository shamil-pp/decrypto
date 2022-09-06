import 'package:flutter/material.dart';

// A class for widget
class CryptoCard extends StatelessWidget {
  final String selectedCurrency;
  final String cryptoCurrency;
  final String coinValue;

  // Creates constructor and passes selectedCurrency, cryptoCurrency and coinValue into it
  CryptoCard({
    required this.selectedCurrency,
    required this.cryptoCurrency,
    required this.coinValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Card(
        color: const Color(0xff1F1E2A),
        elevation: 5,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
// Updates the Text Widget
            '1 $cryptoCurrency = $coinValue $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
