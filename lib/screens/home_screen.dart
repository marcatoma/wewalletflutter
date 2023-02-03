import 'package:flutter/material.dart';
import 'package:mewallet/models/models.dart';
import 'package:mewallet/providers/providers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            FutureBuilder(
              future: usuarioProvider(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                Usuario user = Usuario.defaultUser();
                if (snapshot.hasData) {
                  user = snapshot.data;
                }
                return HeaderWidget(size: size, user: user);
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 210,
              width: double.infinity,
              child: FutureBuilder(
                future: UsuarioProvider().obtenerCuentasBancarias(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<CuentaBancaria> cuentas = snapshot.data;
                    return ListView.builder(
                      padding: const EdgeInsets.only(
                          right: 10), // padding al lado derecho de la tarjeta
                      scrollDirection: Axis.horizontal,
                      itemCount: cuentas.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardWidget(
                          nombre: cuentas[index].banco.institucion,
                          balance: cuentas[index].montoEfectivo,
                          color: Colors.blueAccent,
                          cuentaBancaria: cuentas[index],
                        );
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('ha ocurrido un error.'),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SpendIncome(size: size),
                  SpendIncome(size: size),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Transacciones',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                    Text('Ver todo',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent))
                  ]),
            ),
            TransaccionesWidget(size: size)
          ],
        ),
      ),
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
          const SizedBox(width: 10),
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
