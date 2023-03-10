import 'package:bakery/libraries/models.dart';
import 'package:bakery/libraries/views.dart';

class Ingredients extends DefaultDatabaseInfo {
  RxBool? selected;
  String? name;
  String? unitOfMeasurement;
  num? quantityInPackage;
  num? cost;

  Ingredients({
    this.selected,
    String? id,
    this.name,
    DateTime? createdAt,
    String? storeCode,
    this.unitOfMeasurement,
    this.quantityInPackage,
    this.cost,
  }) : super(
          id: id,
          storeCode: storeCode,
          createdAt: createdAt,
        );

  Ingredients.fromJson(Map<String, dynamic> json)
      : 
        selected = false.obs,
        name = json['name'],
        unitOfMeasurement = json['unitOfMeasurement'],
        quantityInPackage = json['quantInPackage'],
        cost = json['cost'],
        super(
          id: json['_id'],
          storeCode: json['storeCode'],
          createdAt: DateTime.tryParse(json['createdAt']),
        );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'storeCode': storeCode,
      'unitOfMeasurement': unitOfMeasurement,
      'quantInPackage': quantityInPackage,
      'cost': cost,
    };
  }

  static List<Ingredients?> toList(List? json) {
    if (json == null) {
      return [];
    } else {
      return json.map((e) => Ingredients.fromJson(e)).toList();
    }
  }
}

// _id: {type: String},
// name: {type: String, required: true},
// storeCode: {type: String, required: true},
// unitOfMeasurement: {type: String, default: "un"},
// quantInPackage: {type: Number, default: 1},
// cost: {type: Number, default: 0.0},