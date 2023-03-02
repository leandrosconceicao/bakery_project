import 'package:bakery/libraries/utils.dart';

import '/libraries/controllers.dart';

import '../../../libraries/models.dart';
import '/libraries/views.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage>
    with SingleTickerProviderStateMixin {
  late final TabController tab;
  final title = 'Receitas';

  final selectedReceipt = Rxn<Receipts?>();

  @override
  Widget build(BuildContext context) {
    ReceiptsController.load();
    return DefaultPage(
      title: title,
      appBarTitle: Text(title),
      // floatingAction: FloatingActionButton(
      //   onPressed: () => manageItem(),
      //   child: const Icon(Icons.add),
      // ),
      child: _body(),
    );
  }

  Widget _body() {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Column(
          children: [
            Expanded(
                child: AppBlocBuilder<List<Receipts?>>(
                    bloc: ReceiptsController.bloc, child: itemsList)),
            FloatingActionButton(
              onPressed: () => changeIndex(1),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
          ],
        ),
      ]
    );
  }

  Widget itemsList(List<Receipts?>? data) {
    if (data?.isEmpty ?? true) {
      return Center(
          child: Text(
        'Nenhum item cadastrado no momento',
        style: Get.textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ));
    }
    return ListView.builder(
      itemCount: data?.length ?? 0,
      itemBuilder: (context, int i) {
        final item = data?[i];
        // final func = Functions(number: item?.cost);
        return ListTile(
          leading: const Icon(
            Icons.label,
            size: 40,
          ),
          // subtitle: Text('${func.getMoney()}'),
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
                  changeIndex(1, receipt: item);
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
    final req = await ReceiptsController.post(
        // Ingredients(
        //     cost: ingreForm.getCost(),
        //     name: ingreForm.getName(),
        //     quantityInPackage: ingreForm.getQtdPkg(),
        //     unitOfMeasurement: ingreForm.getUnit(),
        //     storeCode: app.storeCode),
        );
    if (!req.result) {
      Get.defaultDialog(title: 'Atenção', middleText: req.message);
    } else {
      Get.back();
      ReceiptsController.load();
    }
  }

  Future<void> editItem({Receipts? data}) async {
    final req = await ReceiptsController.update(
      id: data?.id ?? '',
      // data: Ingredients(
      //   cost: ingreForm.getCost(),
      //   name: ingreForm.getName(),
      //   quantityInPackage: ingreForm.getQtdPkg(),
      //   unitOfMeasurement: ingreForm.getUnit(),
      //   storeCode: app.storeCode
      // )
    );
    if (!req.result) {
      Get.defaultDialog(title: 'Atenção', middleText: req.message);
    } else {
      Get.back();
      ReceiptsController.load();
    }
  }

  Future<void> delItem({Receipts? data}) async {
    final req = await ReceiptsController.delete(data: data);
    if (!req.result) {
      Get.defaultDialog(title: 'Atenção', middleText: req.message);
    } else {
      Get.rawSnackbar(
          message:
              'Item foi excluido com sucesso, caso queira restaurar clique aqui.',
          onTap: (_) async {
            // final r = await ReceiptsController.post(req.data);
            // if (!r.result) {
            //   Get.defaultDialog(title: 'Atenção', middleText: r.message);
            // }
          });
      ReceiptsController.load();
    }
  }

  void changeIndex(int value, {Receipts? receipt}) {
    if (value == 0) {
      selectedReceipt.value = null;
    } else {
      selectedReceipt.value = receipt;
    }
    tab.animateTo(value, curve: Curves.easeIn);
  }

  @override
  void initState() {
    tab = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
      animationDuration: const Duration(
        milliseconds: 500,
      ),
    );
    super.initState();
  }
}
