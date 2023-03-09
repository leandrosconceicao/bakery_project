
import '../../../libraries/utils.dart';
import '../../../libraries/views.dart';

class NotFoundWarning extends StatelessWidget {
  final String? message;
  const NotFoundWarning({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.25,
              child: Image.asset('${app.staticFolder}/not_found.png')),
              SizedBox(height: Get.height * 0.01,),
            Text(
      message ?? 'Nenhum item cadastrado no momento',
      style: Get.textTheme.headlineMedium,
      textAlign: TextAlign.center,
    ),
          ],
        ));
  }
}