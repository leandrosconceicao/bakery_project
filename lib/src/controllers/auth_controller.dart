import '../../libraries/utils.dart';
import '../../libraries/models.dart';

class AuthController {
  static Future<ApiRes<User?>> check() async {
    final req = await Api.request<User?>(
      method: ApiMethods.post,
      endpoint: Endpoints.authentication,
      body: {
        "email": authForm.email.text,
        "password": authForm.pass.text,
      },
      function: User.fromJson
    );
    if (req.result) {
      app.loggedUser.value = req.data;
      app.storeCode = app.loggedUser.value?.ests!.firstOrNull?.stores?.firstOrNull?.id;
      authForm.saveSession();
    }
    return req;
  }
}
