import '../../../libraries/models.dart';
import '../../../libraries/views.dart';

class RouterGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case Routes.home:
        return _goToRoute(const Home(), Routes.home);

      case Routes.configs:
        return _goToRoute(Config(), Routes.configs);
      default:
        return _goToRoute(SigninPage(), Routes.signin);
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
