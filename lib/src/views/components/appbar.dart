import '../../../libraries/models.dart';
import '../../../libraries/utils.dart';
import '/libraries/views.dart';

class MyAppBar {
  static PreferredSizeWidget build({Widget? title}) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: title,
      centerTitle: true,
      actions: [
        Obx(() => Visibility(
          visible: app.loggedUser.value != null,
          child: IconButton(onPressed: () {
            app.clearData();
            Get.offNamedUntil(Routes.signin, (route) => false);
          }, icon: const Icon(Icons.logout))))
      ],
    );
  }
}