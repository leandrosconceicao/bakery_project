import '../../../libraries/models.dart';
import '/libraries/views.dart';
import '/libraries/utils.dart';

class AuthenticationForm {
  final email = TextEditingController();
  final pass = TextEditingController();
  final emailFcs = FocusNode();
  final passFcs = FocusNode();

  final formKey = GlobalKey<FormState>();

  void saveSession() {
    final prefs = GetStorage();
    if (app.loggedUser.value != null) {
      prefs.write(
        'session',
        {
          "expiration":
              DateTime.now().add(const Duration(days: 1)).toIso8601String(),
          "userData": app.loggedUser.value?.toJson(),
          "storeCode": app.storeCode
        },
      );
    }
  }

  bool getSession() {
    final prefs = GetStorage();
    try {
      final data = prefs.read<Map<String, dynamic>>('session');
      if (data == null) {
        return false;
      }
      DateTime exp = DateTime.parse(data['expiration']);
      DateTime now = DateTime.now();
      if (now.difference(exp).inDays > 1) {
        prefs.erase();
        return false;
      }
      final user = User.fromJson(data['userData']);
      if (user.email == null) {
        prefs.erase();
        return false;
      }
      String? storeCode = data['storeCode'];
      if (storeCode == null) {
        prefs.erase();
        return false;
      }
      app.storeCode = storeCode;
      app.loggedUser.value = user;
      return true;
    } catch (_) {
      prefs.erase();
      return false;
    }
  }

  void clearSession() {
    final prefs = GetStorage();
    prefs.erase();
  }
}

final authForm = AuthenticationForm();
