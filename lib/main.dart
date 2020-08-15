import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'home.dart';

main() => runApp(new MaterialApp(
      home: MyApp(),
      theme: ThemeData(
          primarySwatch: Colors.yellow,
          primaryColor: defaultTargetPlatform == TargetPlatform.windows
              ? Colors.grey[100]
              : null),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('CryptoCurrencyy App',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25.00,
                color: Colors.black)),
      ),
      body: HomePage(),
    );
  }
}
