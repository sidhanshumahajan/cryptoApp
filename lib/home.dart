import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:universal_io/io.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data;
  List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  @override
  void initState() {
    super.initState();
    this.getCurrencies();
  }

  Future<String> getCurrencies() async {
    String url =
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=6c7c2f02-2bc0-423f-8821-d938b8e7f325&limit=20';

    http.Response response = await http.get(url);
    data = convert.jsonDecode(response.body);
    return "Sucess";
  }

  @override
  Widget build(BuildContext context) {
    return _cryptoWidget();
  }

  Widget _cryptoWidget() {
    return new Container(
      child: Column(children: <Widget>[
        new Flexible(
          child: new ListView.builder(
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                final Map currency = data[index];
                final MaterialColor color = _colors[index % _colors.length];
                return _getListItemUI(currency, color);
              }),
        ),
      ]),
    );
  }

  ListTile _getListItemUI(Map currency, MaterialColor color) {
    return ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currency['name'][0]),
      ),
      title: new Text(currency['name'],
          style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: _getSubTitleText(
          currency['price_usd'], currency['percent_change_1h']),
    );
  }

  Widget _getSubTitleText(String price, String percentageChange) {
    TextSpan priceTextWidget = new TextSpan(
        text: '\$$price\n', style: new TextStyle(color: Colors.black));
    String percentageChangeText = "1 hour:$percentageChange";
    TextSpan percentageChangeTextWidget;

    if (double.parse(percentageChange) > 0) {
      percentageChangeTextWidget = new TextSpan(
          text: percentageChangeText,
          style: new TextStyle(color: Colors.green));
    } else {
      percentageChangeTextWidget = new TextSpan(
          text: percentageChangeText, style: new TextStyle(color: Colors.red));
    }
    return new RichText(
        text: new TextSpan(
            children: [priceTextWidget, percentageChangeTextWidget]));
  }
}
