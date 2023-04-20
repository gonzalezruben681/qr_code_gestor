import 'dart:convert';

ContactoModel contactoFromJson(String str) =>
    ContactoModel.fromJson(json.decode(str));

String contactoToJson(ContactoModel data) => json.encode(data.toJson());

class ContactoModel {
  final String nombre;
  final String telefono;
  final String? id;
  final String? idOpcion;

  ContactoModel({
    this.idOpcion,
    this.id,
    required this.nombre,
    required this.telefono,
  });

  factory ContactoModel.fromJson(Map<String, dynamic> json) => ContactoModel(
        nombre: json['nombre'],
        telefono: json['telefono'],
        id: json["id"] ?? '0',
        idOpcion: json['id_opcion'],
      );

  Map<String, dynamic> toJson() => {
        "name": nombre,
        "telefono": telefono,
        "id": id,
        "id_opcion": idOpcion,
      };
}
