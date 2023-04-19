import 'dart:convert';

OptionModel opcionModelFromJson(String str) =>
    OptionModel.fromJson(json.decode(str));

String opcionModelToJson(OptionModel data) => json.encode(data.toJson());

class OptionModel {
  final String id;
  final String option;

  OptionModel({required this.id, required this.option});

  factory OptionModel.fromJson(Map<String, dynamic> json) => OptionModel(
        option: json["opcion"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "opcion": option,
        "id": id,
      };
}
