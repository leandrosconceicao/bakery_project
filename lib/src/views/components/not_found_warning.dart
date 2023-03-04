
import '../../../libraries/utils.dart';
import '../../../libraries/views.dart';

class NotFoundWarning extends StatelessWidget {
  const NotFoundWarning({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              child: Image.asset('${app.staticFolder}/not_found.png')),
              SizedBox(height: Get.height * 0.01,),
            Text(
      'Nenhum item cadastrado no momento',
      style: Get.textTheme.headlineMedium,
      textAlign: TextAlign.center,
    ),
          ],
        ));
  }
}