import 'package:flutter/material.dart';
import 'package:mewallet/models/models.dart';

class CardWidget extends StatelessWidget {
  final String nombre;
  final double balance;
  final Color color;
  final CuentaBancaria cuentaBancaria;
  const CardWidget({
    Key? key,
    required this.nombre,
    required this.balance,
    required this.color,
    required this.cuentaBancaria,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Codigo de color: ' + color.value.toString());
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
                    width: 50, image: AssetImage('assets/icons/visa.png'))),
            Positioned(
                left: 20,
                top: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Número de cuenta'),
                    Text(
                      cuentaBancaria.numeroCuenta,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
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
                    onPressed: () => Navigator.pushNamed(
                        context, '/movimientos',
                        arguments: {'id_cuenta_bancaria': cuentaBancaria.id}),
                    icon: const Icon(
                      Icons.sync_alt,
                      size: 30,
                    ))),
            Positioned(
                right: 30,
                bottom: 70,
                child: IconButton(
                    color: Colors.white,
                    splashColor: Colors.red,
                    onPressed: () =>
                        Navigator.pushNamed(context, '/card_config'),
                    icon: const Icon(
                      Icons.mode_edit_outline,
                      size: 30,
                    ))),
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
