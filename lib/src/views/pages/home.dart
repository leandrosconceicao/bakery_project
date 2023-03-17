import 'package:bakery/libraries/controllers.dart';
import 'package:bakery/libraries/models.dart';

import '../../../libraries/utils.dart';
import '../../../libraries/views.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: 'Home',
      appBarTitle: const Text('Home', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      child: _body(),
    );
  }

  Widget _body() {
    ConfigController.load();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Obx(
            () => ListTile(
              onTap: app.defaultConfig.value != null ? null :  () {
                  Get.offNamed(Routes.configs);
              },
              shape: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              tileColor: MyPallete.defaultColor.shade50,
              leading: Icon(Icons.account_balance, color: Colors.black, size: Get.height * 0.04,),
              title: Text('Mão de Obra/hora', style: Get.textTheme.headlineSmall,),
              subtitle: app.defaultConfig.value == null ? const Text('Clique aqui para configurar') : Text('${app.defaultConfig.value?.getAverageGain() ?? ''}'),
            ),
          )
        ],
      ),
    );
  }
}
