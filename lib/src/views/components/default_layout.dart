import '../../../libraries/models.dart';
import '../../../libraries/views.dart';

class DefaultPage extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? appBarTitle;
  final Widget? floatingAction;
  const DefaultPage({super.key, required this.title, required this.child, this.appBarTitle, this.floatingAction});


  @override
  Widget build(BuildContext context) {
    return Title(
      color: Get.theme.primaryColor,
      title: title,
      child: Scaffold(
        drawer: Get.currentRoute == Routes.signin ? null : AppDrawer(),
        appBar: MyAppBar.build(title: appBarTitle),
        body: child,
        floatingActionButton: floatingAction,
      ),
    );
  }
}