import 'package:flutter/material.dart';
import 'package:mewallet/models/models.dart';
import 'package:mewallet/providers/usuarios_provider.dart';
import 'package:mewallet/widgets/HomeScreenWidgets/home_screen_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
          future: usuarioProvider(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            Usuario user = Usuario.defaultUser();
            if (snapshot.hasData) {
              user = snapshot.data;
            }
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderWidget(size: size, user: user),
                  const SizedBox(height: 10),
                  Container(
                    height: 210,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        CardWidget(
                            nombre: 'Marcatoma',
                            balance: 99.999,
                            color: Colors.blue),
                        CardWidget(
                            nombre: 'Christian',
                            balance: 99.999,
                            color: Colors.lightBlue),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String nombre;
  final double balance;
  final Color color;
  const CardWidget({
    Key? key,
    required this.nombre,
    required this.balance,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      height: 200,
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: color,
      ),
      child: Stack(
        children: [
          Positioned(
              top: 15,
              left: 20,
              child: Text(
                nombre,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              )),
          const Positioned(
              top: 15,
              right: 25,
              child: Image(
                width: 50,
                image: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/4/41/Visa_Logo.png'),
              )),
          const Positioned(
            bottom: 70,
            left: 20,
            child: Text(
              'Balance',
              style: TextStyle(color: Colors.white70, fontSize: 22),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 20,
            child: Row(
              children: [
                const Text(
                  '\$',
                  style: TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Text(
                  '$balance',
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Positioned(
              right: 30,
              bottom: 30,
              child: IconButton(
                  color: Colors.white,
                  splashColor: Colors.red,
                  onPressed: () {},
                  icon: Icon(
                    Icons.sync_alt,
                    size: 30,
                  )))
        ],
      ),
    );
  }
}
