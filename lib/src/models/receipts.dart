import '../../libraries/models.dart';

class Receipts extends DefaultDatabaseInfo {
  String? name;
  List<Ingredients?>? ingredients;

  Receipts({
    this.name,
    this.ingredients,
    DateTime? createdAt,
    required String storeCode,
    String? id,
  }) : super(id: id, storeCode: storeCode, createdAt: createdAt);

  Receipts.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        ingredients = Ingredients.toList(json['ingredients']),
        super(
          id: json['_id'],
          storeCode: json['storeCode'],
          createdAt: DateTime.tryParse(json['createdAt']),
        );

  Map<String, dynamic> toJson() {
    return {
      "storeCode": storeCode,
      "name": name,
      "ingredients": ingredients?.map((e) => e?.toJson()).toList()
    };
  }

  num? get totalCost => ingredients?.fold(
      0.0,
      (previousValue, element) =>
          (element?.cost ?? 0.0) + (previousValue ?? 0.0));

  static List<Receipts?> toList(List? json) {
    if (json == null) {
      return [];
    }
    return json.map((e) => Receipts.fromJson(e)).toList();
  }
}

// _id: {type: String},
// storeCode: {type: String, required: true},
// name: {type: String, required: true},
// createdAt: {type: Date, default: new Date()},
// ingredients: {
//     type: [ingredientsBody]
// }