import 'package:flutter/material.dart';

import 'presentation/screens/cards_screen/cards_screen.dart';
import 'presentation/service_locator/service_locator.dart';

void main() {
  initServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'flippy Cards',
      home: const CardsScreens(),
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.cyanAccent
      ),
    );
  }
}