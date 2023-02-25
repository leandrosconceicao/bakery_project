import 'package:bakery/libraries/utils.dart';

import '/libraries/controllers.dart';

import '../../../libraries/models.dart';
import '/libraries/views.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

   @override
  Widget build(BuildContext context) {
    IngredientsController.load();
    return DefaultPage(
      title: 'Ingredientes',
      appBarTitle: const Text('Ingredientes'),
      floatingAction: FloatingActionButton(
        onPressed: () => manageItem(),
        child: const Icon(Icons.add),
      ),
      child: _body(),
    );
  }

  Widget _body() {
    return Column(children: [
      Expanded(child: AppBlocBuilder<List<Ingredients?>>(bloc: IngredientsController.bloc, child: itemsList)),
      SizedBox(
        height: 20,
      ),
    ],);
  }

  void manageItem({bool isEdit=false}) {
    Get.dialog(WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        scrollable: true,
        title: Text(isEdit ? 'Editar item' : 'Adicionar item'),
        content: IngredientManager(isEdit: isEdit),
        actions: [
          LoadingButton(label: const Text('Salvar'), process: () {}),
          TextButton(onPressed: () => Get.back(), child: const Text('Cancelar'))
        ],
      ),
    ), barrierDismissible: false);
  }

  Widget itemsList(List<Ingredients?>? data) {
    if (data?.isEmpty ?? true) {
      return Center(child: Text('Nenhum item cadastrado no momento', style: Get.textTheme.headlineMedium, textAlign: TextAlign.center,));
    }
    return ListView.builder(
      itemCount: data?.length ?? 0,
      itemBuilder: (context, int i) {
        final item = data?[i];
        return ListTile(
          title: Text(item?.name ?? ''),
        );
      },
    );
  }

  Future<void> saveItem() async {
    final req = await IngredientsController.post(Ingredients(
      cost: ingreForm.getCost(),
      name: ingreForm.getName(),
      quantityInPackage: ingreForm.getQtdPkg(),
      unitOfMeasurement: ingreForm.getUnit(),
    ));
  }
}
