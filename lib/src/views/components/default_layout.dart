import 'dart:isolate';

import '../../../libraries/models.dart';
import '../../../libraries/utils.dart';
import '../../../libraries/views.dart';

class DefaultPage extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? appBarTitle;
  final Widget? floatingAction;
  final bool? hideAppBar;
  DefaultPage({
    super.key,
    required this.title,
    required this.child,
    this.appBarTitle,
    this.floatingAction,
    this.hideAppBar,
  });

  final keyboardIsVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Title(
      color: Get.theme.primaryColor,
      title: title,
      child: SafeArea(
        child: Scaffold(
          // drawer: Get.currentRoute == Routes.signin ? null : const AppDrawer(),
          // appBar: (hideAppBar ?? false) ? null : MyAppBar.build(title: appBarTitle),
          body: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(title, style: Get.textTheme.headlineMedium,),
                  ),
                  Expanded(child: child),
                ],
              ),
              if (Get.currentRoute != Routes.signin) ... {
                Obx(() => keyboardIsVisible.value ? const SizedBox() : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Card(
                    elevation: 8.0,
                    color: MyPallete.defaultColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          menuItem(func: () => Get.toNamed(Routes.home), icon: Icons.home, route: Routes.home),
                          menuItem(func: () => Get.toNamed(Routes.ingredients), icon: Icons.label, route: Routes.ingredients),
                          menuItem(func: () => Get.toNamed(Routes.receipt), icon: Icons.receipt_long, route: Routes.receipt),
                          menuItem(func: () => Get.toNamed(Routes.configs), icon: Icons.settings, route: Routes.configs),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
              }
            ],
          ),
          // floatingActionButton: floatingAction,
        ),
      ),
    );
  }

  Widget menuItem({
    required void Function() func,
    required IconData icon,
    required String route,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: func,
        child: Icon(icon, color: app.isActiveRoute(route) ? Colors.white : Colors.grey, size: app.isActiveRoute(route) ? (Get.height * 0.04) : (Get.height * 0.035),)),
    );
  }
}
