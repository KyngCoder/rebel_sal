


import 'package:fireworks_demo/curtin_anim.dart';
import 'package:fireworks_demo/home_screen.dart';
import 'package:fireworks_demo/quiz_screen.dart';

import 'package:flutter/material.dart';

import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(MaterialApp(
    title: 'Rebel Salute 2024',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.black,
        secondary: Colors.yellowAccent,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionColor: Colors.yellow,
        selectionHandleColor: Colors.yellowAccent,
      ),
    ),
    home: Scaffold(
      backgroundColor: Colors.black,
      body: HomeScreen()
    ),
  ));
}

