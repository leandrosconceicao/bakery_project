
import '../../../libraries/models.dart';
import '../../../libraries/utils.dart';
import '../../../libraries/views.dart';

class DefaultPage extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? appBarTitle;
  final Widget? floatingAction;
  final bool? hideAppBar;

  const DefaultPage({
    super.key,
    required this.title,
    required this.child,
    this.appBarTitle,
    this.floatingAction,
    this.hideAppBar,
  });


  @override
  Widget build(BuildContext context) {
    return Title(
      color: Get.theme.primaryColor,
      title: title,
      child: Scaffold(
        // drawer: Get.currentRoute == Routes.signin ? null : const AppDrawer(),
        appBar: (hideAppBar ?? false) ? null : MyAppBar.build(title: appBarTitle),
        bottomNavigationBar: Get.currentRoute != Routes.signin ? BottomAppBar(
          color: MyPallete.defaultColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 8.0,
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    menuItem(
                        func: () =>
                            Get.toNamed(Routes.home),
                        icon: Icons.home,
                        route: Routes.home),
                    menuItem(
                        func: () =>
                            Get.toNamed(Routes.ingredients),
                        icon: Icons.label,
                        route: Routes.ingredients),
                    menuItem(
                        func: () =>
                            Get.toNamed(Routes.receipt),
                        icon: Icons.receipt_long,
                        route: Routes.receipt),
                    menuItem(
                        func: () =>
                            Get.toNamed(Routes.expenses),
                        icon: Icons.bar_chart_rounded,
                        route: Routes.expenses),
                    menuItem(
                        func: () =>
                            Get.toNamed(Routes.configs),
                        icon: Icons.settings,
                        route: Routes.configs),
                  ],
                ),
              ),
            ),
          ),
        ) : null,
        body: child,
        floatingActionButton: floatingAction,
      ),
    );
  }

  Widget menuItem({
    required void Function() func,
    required IconData icon,
    required String route,
  }) {
    return IconButton(
      
      onPressed: func,
      icon: Icon(
        icon,
        color: app.isActiveRoute(route) ? Colors.white : Colors.grey,
        size: app.isActiveRoute(route)
            ? (Get.height * 0.04)
            : (Get.height * 0.035),
      ),
    );
  }
}
