class TipoCuenta {
  TipoCuenta({
    required this.id,
    required this.tipo,
  });

  int id;
  String tipo;

  factory TipoCuenta.fromJson(Map<String, dynamic> json) => TipoCuenta(
        id: json["id"],
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
      };
}
