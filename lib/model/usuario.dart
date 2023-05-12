class Usuario {
  String nombre;
  String correo;
  String telefono;

  Usuario({
    required this.nombre,
    required this.correo,
    required this.telefono,
  });

  // Convert Usuario to a Map<String, String> object
  Map<String, String> toMap() {
    return {
      'nombre': nombre,
      'correo': correo,
      'telefono': telefono,
    };
  }
}
