import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:mewallet/models/models.dart';

Future usuarioProvider() async {
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview
  var url = Uri.https('marcatoma-wewallet.herokuapp.com', '/usuario/chrisadr');

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
