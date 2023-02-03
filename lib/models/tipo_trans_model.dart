import 'package:mewallet/models/models.dart';

class TipoTransList {
  TipoTransList({
    required this.tipoTransaccion,
    required this.mensaje,
  });

  List<TipoTrans> tipoTransaccion = [];
  String mensaje;

  factory TipoTransList.fromJson(Map<String, dynamic> json) => TipoTransList(
        tipoTransaccion: List<TipoTrans>.from(
            json["result"].map((x) => TipoTrans.fromJson(x))),
        mensaje: json["mensaje"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(tipoTransaccion.map((x) => x.toJson())),
        "mensaje": mensaje,
      };
}

class TipoTrans {
  TipoTrans({
    required this.id,
    required this.tipoTrans,
    required this.signo,
  });
  TipoTrans getTipotrans(List<TipoTrans> lista) {
    for (var item in lista) {
      if (item.tipoTrans == tipoTrans) {
        return item;
      }
    }
    return TipoTrans(id: id, tipoTrans: tipoTrans, signo: signo);
  }

  int id;
  String tipoTrans;
  String signo;

  factory TipoTrans.fromJson(Map<String, dynamic> json) => TipoTrans(
        id: json["id"],
        tipoTrans: json["tipoTrans"],
        signo: json["signo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipoTrans": tipoTrans,
      };
}
