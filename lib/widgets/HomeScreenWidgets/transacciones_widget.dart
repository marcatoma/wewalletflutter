import 'package:flutter/material.dart';
import 'package:mewallet/models/models.dart';
import 'package:mewallet/providers/providers.dart';

// widget de transacciones del home Screen
class TransaccionesWidget extends StatelessWidget {
  const TransaccionesWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    // widget de transacciones del home screen
    return SizedBox(
      width: double.infinity,
      // este widget es para el homescreen solamente
      height: size.height * .5,
      child: FutureBuilder(
        future: TransaccionesProvider().obtenerTransacciones(0),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Transaccion> trans = snapshot.data;
            // llama al widget de la lista de transacciones
            return ListaTransacciones(trans: trans);
          } else if (snapshot.hasError) {
            return const Center(
                child:
                    Text('Ha ocurrido un error al obtener las transacciones'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// lsta de transacciones independiente del widget de arriba
class ListaTransacciones extends StatelessWidget {
  const ListaTransacciones({
    Key? key,
    required this.trans,
  }) : super(key: key);

  final List<Transaccion> trans;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: trans.length,
      itemBuilder: (BuildContext context, int index) {
        String signo = trans[index].tipoTrans.signo;
        return Column(
          children: [
            ListTile(
              title: Text(
                trans[index].concepto,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                trans[index].createdAt,
                style: const TextStyle(color: Colors.grey),
              ),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                    'assets/icons/${trans[index].cuentaBancaria.banco.imagen}'),
              ),
              trailing:
                  Text('${trans[index].tipoTrans.signo}\$${trans[index].monto}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: signo == '-' ? Colors.red : Colors.indigo,
                      )),
              onTap: () {
                _modalBottomSheet(context, trans[index]);
              },
            ),
            const Divider(color: Colors.grey)
          ],
        );
      },
    );
  }

  Future<dynamic> _modalBottomSheet(BuildContext context, Transaccion tran) {
    final Transaccion transaccion = tran;
    const TextStyle estiloTrans = TextStyle(fontSize: 18);
    const TextStyle estiloTitulos =
        TextStyle(fontSize: 22, fontWeight: FontWeight.w600);
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: const Icon(Icons.expand_more, size: 40),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: double.infinity, height: 1),
              const Align(
                alignment: Alignment.center,
                child: Text('Detalle de Transacción',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    transaccion.cuentaBancaria.banco.institucion,
                    style: const TextStyle(fontSize: 18),
                  )),
              const SizedBox(height: 20),
              Text('CUENTA ${transaccion.cuentaBancaria.tipoCuenta.tipo}',
                  style: estiloTitulos),
              const SizedBox(height: 10),
              const Text('Fecha transaccion', style: estiloTitulos),
              Text(transaccion.createdAt, style: estiloTrans),
              const SizedBox(height: 10),
              const Text('Concepto', style: estiloTitulos),
              Text(transaccion.concepto, style: estiloTrans),
              const SizedBox(height: 10),
              const Text('Tipo transaccion', style: estiloTitulos),
              Text(transaccion.tipoTrans.tipoTrans, style: estiloTrans),
              const SizedBox(height: 10),
              const Text('Monto de transaccion', style: estiloTitulos),
              Text(transaccion.monto.toString(), style: estiloTrans),
              const SizedBox(height: 10),
              const Text('Comision', style: estiloTitulos),
              const Text('0.0', style: estiloTrans),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}
