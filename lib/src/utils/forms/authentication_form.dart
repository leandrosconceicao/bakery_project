import '/libraries/views.dart';

class AuthenticationForm {
  final email = TextEditingController();
  final pass = TextEditingController();
  final emailFcs = FocusNode();
  final passFcs = FocusNode();

  final formKey = GlobalKey<FormState>();
}

final authForm = AuthenticationForm();