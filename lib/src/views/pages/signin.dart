import '../../../libraries/controllers.dart';
import '../../../libraries/models.dart';
import '../../../libraries/utils.dart';
import '../../../libraries/views.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final btnFocus = FocusNode();
  final title = 'Faça seu login';

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: title,
      hideAppBar: true,
      appBarTitle: Text(title, style: Get.textTheme.headlineSmall),
      child: _body(),
    );
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('${app.staticFolder}/login.jpg'),
              TextFormField(
                validator: (String? value) => (value?.isEmpty ?? true) ? 'Obrigatório' : null,
                onFieldSubmitted: (_) => authForm.passFcs.requestFocus(),
                textAlign: TextAlign.center,
                style: Get.textTheme.headlineMedium,
                controller: authForm.email,
                focusNode: authForm.emailFcs,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                validator: (String? value) => (value?.isEmpty ?? true) ? 'Obrigatório' : null,
                onFieldSubmitted: (_) => btnFocus.requestFocus(),
                textAlign: TextAlign.center,
                style: Get.textTheme.headlineMedium,
                controller: authForm.pass,
                focusNode: authForm.passFcs,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              SizedBox(
                width: Get.width,
                height: Get.height * 0.06,
                child: LoadingButton(
                  focus: btnFocus,
                  label: Text(
                    'Autenticar',
                    style: Get.textTheme.headlineSmall,
                  ),
                  process: () async {
                    await auth();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> auth() async {
    if (formKey.currentState?.validate() ?? false) {
      final req = await AuthController.check();
      if (!req.result) {
        Get.defaultDialog(middleText: req.message);
      } else {
        Get.offNamed(Routes.home);
      }
    }
  }
}
