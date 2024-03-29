import 'dart:async';
import 'package:flutter/material.dart';
import 'src/landingPage.dart';
import 'package:flutter/foundation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LandingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
