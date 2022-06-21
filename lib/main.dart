import 'package:flutter/material.dart';
import 'package:mewallet/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Me Wallet App',
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
      },
    );
  }
}
