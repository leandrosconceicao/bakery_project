import '../../../libraries/models.dart';
import '../../../libraries/utils.dart';
import '../../../libraries/views.dart';

class RouterGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case Routes.home:
        return _goToRoute(const Home(), Routes.home);

      case Routes.configs:
        const r = Routes.configs;
        app.setRoute(r);
        return _goToRoute(const Config(), r);
      case Routes.ingredients:
        const r = Routes.ingredients;
        app.setRoute(r);
        return _goToRoute(const IngredientsPage(), r);
      case Routes.receipt:
        const r = Routes.receipt;
        app.setRoute(r);
        return _goToRoute(const ReceiptPage(), r);
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
