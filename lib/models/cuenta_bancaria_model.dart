import 'package:mewallet/models/models.dart';

CuentaBancariaList cuentasBancariasFromJson(Map<String, dynamic> json) =>
    CuentaBancariaList.fromJson(json);

class CuentaBancariaList {
  CuentaBancariaList({
    required this.mensaje,
    required this.result,
  });

  String mensaje;
  List<CuentaBancaria> result;

  factory CuentaBancariaList.fromJson(Map<String, dynamic> json) =>
      CuentaBancariaList(
        mensaje: json['mensaje'],
        result: List<CuentaBancaria>.from(
            json['result'].map((x) => CuentaBancaria.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class CuentaBancaria {
  CuentaBancaria({
    required this.id,
    required this.numeroCuenta,
    required this.montoEfectivo,
    required this.montoCredito,
    required this.banco,
    required this.tipoCuenta,
  });

  int id;
  String numeroCuenta;
  double montoEfectivo;
  double montoCredito;
  Banco banco;
  TipoCuenta tipoCuenta;

  factory CuentaBancaria.fromJson(Map<String, dynamic> json) => CuentaBancaria(
        id: json["id"],
        numeroCuenta: json["numeroCuenta"],
        montoEfectivo: json["montoEfectivo"].toDouble(),
        montoCredito: json["montoCredito"].toDouble(),
        banco: Banco.fromJson(json["banco"]),
        tipoCuenta: TipoCuenta.fromJson(json["tipoCuenta"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "numeroCuenta": numeroCuenta,
        "montoEfectivo": montoEfectivo,
        "montoCredito": montoCredito,
      };
}
