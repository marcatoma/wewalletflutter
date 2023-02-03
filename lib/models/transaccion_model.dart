import 'package:mewallet/models/models.dart';

class TransaccionList {
  TransaccionList({
    required this.transaccion,
    required this.mensaje,
  });

  List<Transaccion> transaccion;
  String mensaje;

  factory TransaccionList.fromJson(Map<String, dynamic> json) =>
      TransaccionList(
        transaccion: List<Transaccion>.from(
            json['result'].map((x) => Transaccion.fromJson(x))),
        mensaje: json['mensaje'],
      );
}

class Transaccion {
  Transaccion({
    required this.id,
    required this.tipoTrans,
    required this.concepto,
    required this.monto,
    required this.usuario,
    required this.createdAt,
    required this.updatedAt,
    required this.cuentaBancaria,
  });

  int id;
  TipoTrans tipoTrans;
  String concepto;
  double monto;
  Usuario usuario;
  dynamic createdAt;
  dynamic updatedAt;
  CuentaBancaria cuentaBancaria;

  factory Transaccion.fromJson(Map<String, dynamic> json) => Transaccion(
        id: json["id"],
        tipoTrans: TipoTrans.fromJson(json["tipoTrans"]),
        concepto: json["concepto"],
        monto: json["monto"].toDouble(),
        usuario: Usuario.fromJsonTransaction(json["usuario"]),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        cuentaBancaria: CuentaBancaria.fromJson(json["cuentaBancaria"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipoTrans": tipoTrans.toJson(),
        "concepto": concepto,
        "monto": monto,
        "usuario": usuario.toJson(),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "cuentaBancaria": cuentaBancaria.toJson(),
      };

  Map<String, dynamic> toJsonNewTrans() => {
        "id": id,
        "tipoTrans": tipoTrans.toJson(),
        "concepto": concepto,
        "monto": monto,
        "usuario": usuario.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "cuentaBancaria": cuentaBancaria.toJson(),
      };
}
