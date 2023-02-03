import 'package:flutter/material.dart';
import 'package:mewallet/models/form_transaction_model.dart';
import 'package:mewallet/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FormTransactionModel()),
      ],
      child: const MyApp(),
    ));

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
        '/card_config': (_) => const CardConfig(),
        '/movimientos': (_) => const MovimientosScreen(),
        '/form_transaccion': (_) => const FormTransaccion(),
      },
      theme: ThemeData.dark(),
    );
  }
}
