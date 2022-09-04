import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/coin_data.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

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
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  // Creates a variable to hold the value and use in Text Widget
  dynamic bitCoinValueInUSD = '?';

  // Creates an async method to await the coin data from coin_data.dart
  void getData() async {
    CoinData coin = CoinData();
    double coinData = await coin.getCoinData();
    setState(() {
      bitCoinValueInUSD = coinData.toInt();
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
        title: const Text('Bitcoin Ticker'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  // Updates the Text Widget
                  '1 BTC = $bitCoinValueInUSD USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            color: Colors.lightBlue,
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
