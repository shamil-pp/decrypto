import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  // Creates object of coin_data.dart
  CoinData coin = CoinData();
  // Default currency value
  String selectedCurrency = 'AUD';

  DropdownButton androidDropdown() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: [
        for (String currency in currenciesList)
          DropdownMenuItem(
            value: currency,
            child: Text(currency),
          ),
      ],
      onChanged: (value) {
        selectedCurrency = value!;
        // Call getData() when the dropdown changes
        getData();
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (i) {
        // Saves the selected currency index to selectedCurrency
        selectedCurrency = currenciesList[i];
        // Call getData() when the picker changes
        getData();
      },
      children: pickerItems,
    );
  }

  // Creates a property to hold the value and use in Text Widget
  dynamic bitCoinValue = '?';

  // Creates an async method to await the coin data from coin_data.dart
  void getData() async {
    double coinOut = await coin.getCoinData(selectedCurrency);
    setState(() {
      bitCoinValue = coinOut.toInt();
    });
  }

  @override
  void initState() {
    super.initState();
    // Calls getData() method when the screen loads up
    getData();
  }

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('ToCrypto')),
        backgroundColor: const Color(0xff19AC6F),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (String cryptoCurrency in cryptoList)
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Card(
                color: const Color(0xff1F1E2A),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    // Updates the Text Widget
                    '1 $cryptoCurrency = $bitCoinValue $selectedCurrency',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
          Container(
            height: 150,
            color: const Color(0xff1F1E2A),
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            child: Center(
              child: isIOS ? androidDropdown() : iosPicker(),
            ),
          )
        ],
      ),
    );
  }
}
