import 'package:flutter/material.dart';
import 'package:mewallet/models/form_transaction_model.dart';
import 'package:mewallet/models/models.dart';
import 'package:mewallet/providers/providers.dart';
import 'package:provider/provider.dart';

class FormTransaccion extends StatelessWidget {
  const FormTransaccion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> idCuencaBancaria =
        ModalRoute.of(context)?.settings.arguments as Map;
    int idCuenta = idCuencaBancaria['id_cuenta_bancaria'];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          centerTitle: true,
          title: const Text('Nueva transaccion'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: FutureBuilder(
            future: TransaccionesProvider().obtenerTipoTransacciones(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return ChangeNotifierProvider(
                    create: (_) => FormTransactionModel(),
                    child: FormTransaction(
                        tipoTrans: snapshot.data, idCuenta: idCuenta));
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error'),
                );
              } else {
                return const LinearProgressIndicator();
              }
            },
          ),
        ));
  }
}

class FormTransaction extends StatelessWidget {
  const FormTransaction({
    Key? key,
    required this.tipoTrans,
    required this.idCuenta,
  }) : super(key: key);
  final List<TipoTrans> tipoTrans;
  final int idCuenta;
  @override
  Widget build(BuildContext context) {
    final formTrans = Provider.of<FormTransactionModel>(context);
    // lista de tipos de transacciones
    final List<DropdownMenuItem<String>> _items = tipoTrans
        .map((e) => DropdownMenuItem<String>(
              value: e.tipoTrans,
              child: Text(e.tipoTrans),
            ))
        .toList();
    //objeto de tipo de transaccion
    TipoTrans tipoTransaccion = TipoTrans(id: 0, signo: '', tipoTrans: '');
    //variables del formulario
    String concepto = '';
    double cantidad = 0.0;
    return SingleChildScrollView(
      child: Form(
        key: formTrans.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cantidad: '),
            TextFormField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              onChanged: (value) => formTrans.cantidad = double.parse(value),
              validator: (value) {
                return (value != null &&
                        value.isNotEmpty &&
                        double.parse(value) > 0)
                    ? null
                    : 'El valor es requerido';
              },
            ),
            const SizedBox(height: 30),
            const Text('Concepto:'),
            TextFormField(
              autocorrect: false,
              onChanged: (value) => formTrans.concepto = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'El concepto es requerido';
              },
            ),
            const SizedBox(height: 30),
            const Text('Tipo Transaccion:'),
            DropdownButtonFormField(
                items: _items,
                onChanged: (dynamic val) {
                  // validar que se aya seleccionado un tipo de transaccion
                  formTrans.tipoTransaccion = val;
                  //settear el valor en el objeto para buscar
                  tipoTransaccion.tipoTrans = val;
                  tipoTransaccion = tipoTransaccion.getTipotrans(tipoTrans);
                },
                validator: (value) {
                  return (value != null)
                      ? null
                      : 'Seleccionar el tipo de transaccion';
                }),
            const SizedBox(height: 30),
            MaterialButton(
                color: Colors.indigoAccent,
                textColor: Colors.white,
                onPressed: formTrans.isLoading
                    ? null
                    : (() async {
                        //quitar el teclado
                        FocusScope.of(context).unfocus();
                        if (!formTrans.isValidForm()) return;
                        formTrans.isLoading = true;
                        print('tipo Transaccion: ' + tipoTransaccion.tipoTrans);
                        Transaccion t = Transaccion(
                            id: 0,
                            tipoTrans: TipoTrans(
                                id: tipoTransaccion.id,
                                tipoTrans: tipoTransaccion.tipoTrans,
                                signo: ''),
                            concepto: formTrans.concepto,
                            monto: formTrans.cantidad,
                            usuario: Usuario(
                                id: 1,
                                email: '',
                                nombre: '',
                                password: '',
                                username: ''),
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                            cuentaBancaria: CuentaBancaria(
                                id: idCuenta,
                                numeroCuenta: '',
                                montoEfectivo: 0,
                                montoCredito: 0,
                                banco:
                                    Banco(id: 0, institucion: '', imagen: ''),
                                tipoCuenta: TipoCuenta(id: 0, tipo: '')));
                        // procesar la informacion, si esta correcto regresa a transacciones con el id de cuenta
                        await TransaccionesProvider()
                            .registrarTransaccion(t)
                            .then((value) => Navigator.pushReplacementNamed(
                                context, '/movimientos',
                                arguments: {'id_cuenta_bancaria': idCuenta}));
                        formTrans.isLoading = false;
                      }),
                child: Text(
                    formTrans.isLoading ? 'Espere...' : 'Guardar transaccion')),
          ],
        ),
      ),
    );
  }
}
