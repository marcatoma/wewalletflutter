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
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  HeaderWidget(size: size, user: user),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 210,
                    width: double.infinity,
                    child: ListView(
                      padding: const EdgeInsets.only(
                          right: 10), // padding al lado derecho de la tarjeta
                      scrollDirection: Axis.horizontal,
                      children: const [
                        CardWidget(
                            nombre: 'Banco del Austro',
                            balance: 99.999,
                            color: Colors.blue),
                        CardWidget(
                            nombre: 'Cooperativa JEP',
                            balance: 99.999,
                            color: Colors.lightBlue),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 20, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SpendIncome(size: size),
                        SpendIncome(size: size),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}

class SpendIncome extends StatelessWidget {
  const SpendIncome({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * .45,
      height: 70,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(187, 234, 249, .5),
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.arrow_upward_sharp,
              size: 50,
              color: Color.fromRGBO(129, 213, 240, 1),
            ),
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Spending',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              Text(
                '\$980',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          ),
        ],
      ),
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        height: 200,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: color,
        ),
        child: Stack(
          children: [
            const Positioned(
                right: 0,
                top: -90,
                child: CircularContainer(
                  color: Color.fromRGBO(98, 178, 240, .5),
                )),
            const Positioned(
                right: -90,
                bottom: -20,
                child: CircularContainer(
                  color: Color.fromRGBO(98, 178, 240, .5),
                )),
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
                    icon: const Icon(
                      Icons.sync_alt,
                      size: 30,
                    )))
          ],
        ),
      ),
    );
  }
}

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
