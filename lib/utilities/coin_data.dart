import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const apiURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'E48724E0-C37A-4138-870B-FC05A0B377DB';

class CoinData {
  // Creates the Asynchronous method getCoinData() that returns a Future (the price data).
  // Take selectedCurrency as an input
  Future getCoinData(String selectedCurrency) async {
    // Creates a url combining the apiURL with the currencies, BTC to USD.
    String requestURL = '$apiURL/BTC/$selectedCurrency?apikey=$apiKey';
    // Makes a GET request to the URL and waits for the response.
    http.Response response = await http.get(
      Uri.parse(requestURL),
    );
    // Checks whether the request was successful.
    if (response.statusCode == 200) {
      String data = response.body;
      // Decodes the JSON data that comes back from CoinApi.io and stores it into variable decodedData
      var decodedData = jsonDecode(data);
      // Gets the rate of coin from decodedData and stores it into variable coinRate
      var coinRate = decodedData['rate'];
      // Output the coinRate from the method.
      return coinRate;
    } else {
      print(response.statusCode);
      // throws an error if our request fails.
      throw 'Problem encountered with the get request';
    }
  }
}
