import 'package:flutter/foundation.dart';

class Establishments {
  int? id;
  String? ownerId;
  String? storeName;
  List<Stores>? stores;
  String? logo;
  bool? selected;

  Establishments({
    this.id,
    this.ownerId,
    this.storeName,
    this.stores,
    this.selected,
    this.logo,
  });

  Establishments.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    ownerId = json['ownerId'];
    storeName = json['storeName'];
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(Stores.fromJson(v));
      });
    }
    logo = json['logo'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['ownerId'] = ownerId;
    data['storeName'] = storeName;
    if (stores != null) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    } else {
      data['stores'] = [];
    }
    data['logo'] = logo;
    return data;
  }

  Map<String, dynamic> toEdit() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ownerId'] = ownerId;
    data['storeName'] = storeName;
    if (stores != null) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    } else {
      data['stores'] = [];
    }
    return data;
  }

  static List<Establishments> toList(List json) =>
      json.map((e) => Establishments.fromJson(e)).toList();

  @override
  bool operator ==(covariant Establishments other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.ownerId == ownerId &&
      other.storeName == storeName &&
      listEquals(other.stores, stores) &&
      other.logo == logo &&
      other.selected == selected;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      ownerId.hashCode ^
      storeName.hashCode ^
      stores.hashCode ^
      logo.hashCode ^
      selected.hashCode;
  }
}

class Stores {
  bool? selected;
  String? id;
  String? location;

  Stores({this.id, this.location, this.selected = false});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['location'] = location;
    return data;
  }

  @override
  bool operator ==(covariant Stores other) {
    if (identical(this, other)) return true;
  
    return 
      other.selected == selected &&
      other.id == id &&
      other.location == location;
  }

  @override
  int get hashCode => selected.hashCode ^ id.hashCode ^ location.hashCode;
}