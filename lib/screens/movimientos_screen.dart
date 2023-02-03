import 'package:flutter/material.dart';
import 'package:mewallet/models/models.dart';
import 'package:mewallet/providers/providers.dart';

class MovimientosScreen extends StatelessWidget {
  const MovimientosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> idCuencaBancaria =
        ModalRoute.of(context)?.settings.arguments as Map;
    int idCuenta = idCuencaBancaria['id_cuenta_bancaria'];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacementNamed(
            context, '/form_transaccion',
            arguments: {'id_cuenta_bancaria': idCuenta}),
        backgroundColor: Colors.indigoAccent,
        child: const Icon(Icons.add_outlined),
      ),
      appBar: AppBar(
        title: const Text('Movimientos'),
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ContainerTransaction(idCuenta: idCuenta),
      ),
    );
  }
}

class ContainerInformation extends StatelessWidget {
  const ContainerInformation({
    Key? key,
    required this.balance,
  }) : super(key: key);
  final double balance;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      // pendiente si se anade mas widgets sino quitar el column por un sizedbox
      child: Column(
        //alineacion vertical
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // alineacion horizontal
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            const Text(
              'Balance total:',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            Text('\$ ${balance.toDouble()}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  // color: Colors.white,
                )),
          ]),
        ],
      ),
    );
  }
}

class ContainerTransaction extends StatelessWidget {
  const ContainerTransaction({
    Key? key,
    required this.idCuenta,
  }) : super(key: key);

  final int idCuenta;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TransaccionesProvider().obtenerTransacciones(idCuenta),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Transaccion> trans = snapshot.data;
          return Column(
            children: [
              // contenedor para mostrar el monto en efectivo e la cienta bancaria
              ContainerInformation(
                  balance: trans[0].cuentaBancaria.montoEfectivo),
              Expanded(
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    width: double.infinity,
                    child: ListaTransacciones(trans: trans)),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(
              child: Text('Ha ocurrido un error al obtener las transacciones'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
