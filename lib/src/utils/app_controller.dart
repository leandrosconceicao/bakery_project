import '/libraries/models.dart';

import '/libraries/views.dart';

AppController app = AppController();

class AppController extends GetxController {
  Map<String, String> headers = {
    "Content-Type": "application/json"
  };
  String requestUrl = const String.fromEnvironment('apiBase');
  String? storeCode;
  final defaultConfig = Rxn<Configs?>();

  final String staticFolder = 'images';
  final loggedUser = Rxn<User?>();

  void clearData() {
    defaultConfig.value = null;
    loggedUser.value = null;
  }
}