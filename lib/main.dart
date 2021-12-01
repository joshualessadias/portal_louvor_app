import 'package:flutter/material.dart';

import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Roboto-Regular',
          colorScheme: ColorScheme(
              primary: const Color(0xFF00ADA7),
              primaryVariant: Colors.teal.shade900,
              secondary: const Color(0xFFF9732A),
              secondaryVariant: Colors.orange.shade900,
              surface: Theme.of(context).colorScheme.primary,
              background: Colors.white,
              error: Colors.red,
              onPrimary: Colors.white,
              onSecondary: Colors.white,
              onSurface: Colors.white,
              onBackground: Colors.black,
              onError: Colors.white,
              brightness: Brightness.light)),
      home: const LoginPage(),
    );
  }
}
