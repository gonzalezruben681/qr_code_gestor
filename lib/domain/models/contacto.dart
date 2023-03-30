class Contacto {
  String nombre;
  String telefono;

  Contacto({required this.nombre, required this.telefono});

  Contacto.fromMap(Map<String, dynamic> map)
      : nombre = map['nombre'],
        telefono = map['telefono'];
}
