import 'dart:convert';

Contacto contactoFromJson(String str) => Contacto.fromJson(json.decode(str));

String contactoToJson(Contacto data) => json.encode(data.toJson());

class Contacto {
  final String nombre;
  final String telefono;
  final String? id;

  Contacto({
    this.id,
    required this.nombre,
    required this.telefono,
  });

  factory Contacto.fromJson(Map<String, dynamic> json) => Contacto(
        nombre: json['nombre'],
        telefono: json['telefono'],
        id: json["id"] ?? '0',
      );

  Map<String, dynamic> toJson() => {
        "name": nombre,
        "telefono": telefono,
        "id": id,
      };
}
