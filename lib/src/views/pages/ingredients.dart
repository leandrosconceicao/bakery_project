import 'package:bakery/libraries/utils.dart';

import '/libraries/controllers.dart';

import '../../../libraries/models.dart';
import '/libraries/views.dart';

class IngredientsPage extends StatelessWidget {
  const IngredientsPage({super.key});

  final title = 'Ingredientes';

  @override
  Widget build(BuildContext context) {
    IngredientsController.load();
    return DefaultPage(
      title: title,
      appBarTitle: Text(title, style: TextStyle(color: Colors.white)),
      floatingAction: FloatingActionButton(
        onPressed: () => manageItem(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      child: _body(),
    );
  }

  Widget _body() {
    return AppBlocBuilder<List<Ingredients?>>(
      bloc: IngredientsController.bloc,
      child: itemsList,
    );
  }

  void manageItem({bool isEdit = false, Ingredients? data}) {
    Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(isEdit ? 'Editar item' : 'Adicionar item'),
            content: IngredientManager(isEdit: isEdit, data: data),
            actions: [
              LoadingButton(
                label: const Text('Salvar'),
                process: () {
                  if (isEdit) {
                    editItem(data: data);
                  } else {
                    saveItem();
                  }
                },
              ),
              TextButton(
                  onPressed: () => Get.back(), child: const Text('Cancelar'))
            ],
          ),
        ),
        barrierDismissible: false);
  }

  Widget itemsList(List<Ingredients?>? data) {
    if (data?.isEmpty ?? true) {
      return const NotFoundWarning();
    }
    return ListView.builder(
      itemCount: data?.length ?? 0,
      itemBuilder: (context, int i) {
        final item = data?[i];
        final func = Functions(number: item?.cost);
        return ListTile(
          leading: const Icon(
            Icons.label,
            size: 40,
          ),
          subtitle: Text('${func.getMoney()}'),
          title: Text(item?.name ?? ''),
          trailing: OptionsButton(
            icon: const Icon(Icons.settings),
            actionsData: [
              ActionsData(value: ActionTypes.edit, title: 'Editar'),
              ActionsData(value: ActionTypes.del, title: 'Excluir'),
            ],
            onSelected: (value) {
              switch (value) {
                case ActionTypes.edit:
                  manageItem(isEdit: true, data: item);
                  break;
                case ActionTypes.del:
                  delItem(data: item);
                  break;
                default:
                  break;
              }
            },
          ),
        );
      },
    );
  }

  Future<void> saveItem() async {
    final req = await IngredientsController.post(
      Ingredients(
          cost: ingreForm.getCost(),
          name: ingreForm.getName(),
          quantityInPackage: ingreForm.getQtdPkg(),
          unitOfMeasurement: ingreForm.getUnit(),
          storeCode: app.storeCode),
    );
    if (!req.result) {
      Get.defaultDialog(title: 'Atenção', middleText: req.message);
    } else {
      Get.back();
      IngredientsController.load();
    }
  }

  Future<void> editItem({Ingredients? data}) async {
    final req = await IngredientsController.update(
        id: data?.id ?? '',
        data: Ingredients(
            cost: ingreForm.getCost(),
            name: ingreForm.getName(),
            quantityInPackage: ingreForm.getQtdPkg(),
            unitOfMeasurement: ingreForm.getUnit(),
            storeCode: app.storeCode));
    if (!req.result) {
      Get.defaultDialog(title: 'Atenção', middleText: req.message);
    } else {
      Get.back();
      IngredientsController.load();
    }
  }

  Future<void> delItem({Ingredients? data}) async {
    final req = await IngredientsController.delete(data: data);
    if (!req.result) {
      Get.defaultDialog(title: 'Atenção', middleText: req.message);
    } else {
      Get.rawSnackbar(
          message:
              'Item foi excluido com sucesso, caso queira restaurar clique aqui.',
          onTap: (_) async {
            final r = await IngredientsController.post(req.data);
            if (!r.result) {
              Get.defaultDialog(title: 'Atenção', middleText: r.message);
            }
          });
      IngredientsController.load();
    }
  }
}
