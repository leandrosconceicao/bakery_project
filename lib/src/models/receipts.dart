import '../../libraries/models.dart';

class Receipts extends DefaultDatabaseInfo {
  String? name;
  DateTime? createdAt;
  List<Ingredients?>? ingredients;

  Receipts({
    this.name,
    this.createdAt,
    this.ingredients,
    required String storeCode,
    required String id,
  }) : super(id: id, storeCode: storeCode);

  Receipts.fromJson(Map<String, dynamic> json)
  : name = json['name'],
    createdAt = json['createdAt'],
    ingredients = Ingredients.toList(json['ingredients']),
    super(id: json['_id'], storeCode:  json['storeCode']);

  Map<String, dynamic> toJson() {
    return {
      "storeCode": storeCode,
      "name": name,
      "createdAt": createdAt,
      "ingredients": ingredients?.map((e) => e?.toJson()).toList()
    };
  }

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