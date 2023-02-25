class Ingredients {
  String? id;
  String? name;
  String? storeCode;
  String? unitOfMeasurement;
  num? quantityInPackage;
  num? cost;

  Ingredients({this.id, this.name, this.storeCode, this.unitOfMeasurement, this.quantityInPackage, this.cost,});

  Ingredients.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    storeCode = json['storeCode'];
    unitOfMeasurement = json['unitOfMeasurement'];
    quantityInPackage = json['quantInPackage'];
    cost = json['cost'];
  }

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