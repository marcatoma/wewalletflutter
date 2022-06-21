class Usuario {
  int id;
  String username;
  String password;
  String nombre;
  Usuario(
      {required this.id,
      required this.username,
      required this.password,
      required this.nombre});
  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json['id'],
        username: json['username'],
        password: json['password'],
        nombre: json['nombre'],
      );
  factory Usuario.defaultUser() => Usuario(
      id: 0, username: 'username', password: 'password', nombre: 'nombre');
}
