class Usuario {
  int id;
  String username;
  String password;
  String nombre;
  String email;
  Usuario(
      {required this.id,
      required this.username,
      required this.password,
      required this.nombre,
      required this.email});
  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      nombre: json['nombre'],
      email: json['email']);
  factory Usuario.fromJsonTransaction(Map<String, dynamic> json) => Usuario(
        id: json['id'],
        username: '',
        password: '',
        nombre: json['nombre'],
        email: '',
      );
  factory Usuario.defaultUser() => Usuario(
      id: 0,
      username: 'username',
      password: 'password',
      nombre: 'nombre',
      email: 'email');
  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "nombre": nombre,
      };
}
