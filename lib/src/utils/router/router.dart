import '../../../libraries/models.dart';
import '../../../libraries/utils.dart';
import '../../../libraries/views.dart';

class RouterGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    // final args = settings.arguments;
    authForm.getSession();
    switch (settings.name) {
      case Routes.home:
        if (app.loggedUser.value == null) {
          return _goToRoute(SigninPage(), Routes.signin);
        }
        return _goToRoute(const Home(), Routes.home);

      case Routes.configs:
        if (app.loggedUser.value == null) {
          return _goToRoute(SigninPage(), Routes.signin);
        }
        const r = Routes.configs;
        app.setRoute(r);
        return _goToRoute(const Config(), r);
      case Routes.ingredients:
        if (app.loggedUser.value == null) {
          return _goToRoute(SigninPage(), Routes.signin);
        }
        const r = Routes.ingredients;
        app.setRoute(r);
        return _goToRoute(const IngredientsPage(), r);
      case Routes.receipt:
        if (app.loggedUser.value == null) {
          return _goToRoute(SigninPage(), Routes.signin);
        }
        const r = Routes.receipt;
        app.setRoute(r);
        return _goToRoute(const ReceiptPage(), r);
      case Routes.expenses:
        if (app.loggedUser.value == null) {
          return _goToRoute(SigninPage(), Routes.signin);
        }
        const r = Routes.expenses;
        app.setRoute(r);
        return _goToRoute(const ExpensesView(), r);
      default:
        const r = Routes.signin;
        app.setRoute(r);
        return _goToRoute(SigninPage(), r);
    }
  }

  static GetPageRoute<dynamic> _goToRoute(Widget screen, String routeName,
          {Object? args}) =>
      GetPageRoute(
          page: () => screen,
          routeName: routeName,
          settings: RouteSettings(
            name: routeName,
            arguments: args,
          ),
          transition: Transition.noTransition);
}
