import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:mewallet/configurations.dart';
import 'package:mewallet/models/models.dart';

class UsuarioProvider {
  Future obtenerCuentasBancarias() async {
    String basepath = PATH;
    var url = Uri.parse('$basepath/cuentabancaria/useraccounts/1');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      try {
        CuentaBancariaList cuentaList = cuentasBancariasFromJson(jsonResponse);
        List<CuentaBancaria> cuenta = cuentaList.result;
        return cuenta;
      } catch (e) {
        print(e);
      }
    }
    print('Request failed with status: ${response.statusCode}.');
  }
}

Future usuarioProvider() async {
  String basepath = PATH;

  var url = Uri.parse('$basepath/usuario/chrisadr');

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var result = jsonResponse['result'];
    Usuario user = Usuario.fromJson(result);
    return user;
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
