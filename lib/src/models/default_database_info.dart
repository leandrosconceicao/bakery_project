abstract class DefaultDatabaseInfo {
  String? storeCode;
  String? id;

  DefaultDatabaseInfo({this.storeCode, this.id});

  DefaultDatabaseInfo.fromJson(Map<String, dynamic> json) {
    storeCode = json['storeCode'];
    id = json['_id'];
  }
}