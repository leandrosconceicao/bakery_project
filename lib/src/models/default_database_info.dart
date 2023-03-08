abstract class DefaultDatabaseInfo {
  String? storeCode;
  String? id;
  DateTime? createdAt;

  DefaultDatabaseInfo({this.storeCode, this.id, this.createdAt,});

  DefaultDatabaseInfo.fromJson(Map<String, dynamic> json) {
    storeCode = json['storeCode'];
    id = json['_id'];
    createdAt = json['createdAt'];
  }
}