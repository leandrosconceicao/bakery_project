import 'package:bakery/libraries/models.dart';

class Expanses extends DefaultDatabaseInfo {
  String? description;
  num? value;

  Expanses({
    this.description,
    this.value,
    String? id,
    String? storeCode,
    DateTime? createdAt,
  }) : super(
          id: id,
          storeCode: storeCode,
          createdAt: createdAt,
        );

  Expanses.fromJson(Map<String, dynamic> json)
      : description = json['description'],
        value = json['value'],
        super(
          id: json['_id'],
          storeCode: json['storeCode'],
          createdAt: DateTime.tryParse(json['createdAt']),
        );

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "value": value,
      "storeCode": storeCode,
    };
  }

  static List<Expanses?> toList(List json) => json.map((e) => Expanses.fromJson(e)).toList();
}