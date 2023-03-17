import '../../libraries/models.dart';

class User {
  String? id;
  bool? ativo;
  String? email;
  List<int>? establishments;
  List<Establishments>? ests;
  String? groupUser;
  String? pass;
  String? nome;

  User(
      {this.id,
      this.ativo,
      this.email,
      this.establishments,
      this.groupUser,
      this.pass,
      this.nome,
      this.ests,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    ativo = json['ativo'];
    email = json['email'];
    establishments = json['establishments'] != null ? json['establishments'].cast<int>(): [];
    groupUser = json['group_user'];
    pass = json['pass'];
    nome = json['username'];
    ests = json['ests'] != null ? Establishments.toList(json['ests']) : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['ativo'] = ativo;
    data['email'] = email;
    data['establishments'] = establishments;
    data['group_user'] = groupUser;
    // data['pass'] = pass;
    data['username'] = nome;
    return data;
  }

  // static bool userHasAccessEnabled() {
  //   return controller.user.value.groupUser == '1' ||
  //                 controller.user.value.groupUser == '99';
  // }

  // static bool userIsAdmin() {
  //   return controller.user.value.groupUser == '99';
  // }

  static toList(List json) => json.map((e) => User.fromJson(e)).toList();
}

