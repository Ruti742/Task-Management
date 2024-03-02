import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';


import 'login.dart';
import 'State.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}

