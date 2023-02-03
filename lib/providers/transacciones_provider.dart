import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mewallet/configurations.dart';
import 'package:mewallet/models/models.dart';

class TransaccionesProvider {
  static final List<TipoTrans> listaTipoTrans = [];
  String basepath = PATH;

  Future registrarTransaccion(Transaccion t) async {
    var url = Uri.parse('$basepath/transaction/new-trans');
    String trans = jsonEncode(Transaccion(
            id: 0,
            tipoTrans: t.tipoTrans,
            concepto: t.concepto,
            monto: t.monto,
            usuario: t.usuario,
            createdAt: t.createdAt,
            updatedAt: t.updatedAt,
            cuentaBancaria: t.cuentaBancaria)
        .toJsonNewTrans());
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: trans);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body.toString());
    } else {
      print(response.body.toString());
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future obtenerTransacciones(int id) async {
    String path = id == 0 ? '/transaction/trans' : '/transaction/trans/$id';
    var url = Uri.parse('$basepath$path');
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (response.statusCode == 200) {
      try {
        var json = _decodificar(response) as Map<String, dynamic>;
        TransaccionList transacciones = TransaccionList.fromJson(json);
        List<Transaccion> trans = transacciones.transaccion;
        return trans;
      } catch (e) {
        print(e.toString());
      }
    }
    print('transacciones Request failed with status: ${response.statusCode}.');
  }

  Future obtenerTipoTransacciones() async {
    var url = Uri.parse('$basepath/transaction/type-transaction');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        var json = _decodificar(response) as Map<String, dynamic>;
        TipoTransList tipoTrans = TipoTransList.fromJson(json);
        List<TipoTrans> trans = tipoTrans.tipoTransaccion;
        print(tipoTrans.mensaje);
        for (var value in trans) {
          listaTipoTrans.add(value);
        }
        return trans;
      } catch (e) {
        print(e);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  dynamic _decodificar(dynamic response) {
    return jsonDecode(utf8.decode(response.bodyBytes));
  }
}
