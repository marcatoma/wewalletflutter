class Banco {
  Banco({
    required this.id,
    required this.institucion,
    required this.imagen,
  });

  int id;
  String institucion;
  String imagen;

  factory Banco.fromJson(Map<String, dynamic> json) => Banco(
      id: json["id"], institucion: json["institucion"], imagen: json["imagen"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "institucion": institucion,
      };
}
