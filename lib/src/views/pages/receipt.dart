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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => ReceiptsController.load(clearValues: false),
      child: DefaultPage(
        title: title,
        appBarTitle: Text(title),
        // floatingAction: FloatingActionButton(
        //   onPressed: () => manageItem(),
        //   child: const Icon(Icons.add),
        // ),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return TabBarView(
        controller: tab,
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
          ReceiptManager(
            tabController: tab,
          )
        ]);
  }

  Widget itemsList(List<Receipts?>? data) {
    if (data?.isEmpty ?? true) {
      return const NotFoundWarning();
    }
    return ListView.builder(
      itemCount: data?.length ?? 0,
      itemBuilder: (context, int i) {
        final item = data?[i];
        return Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.receipt_long,
                size: 40,
              ),
              title: Text(item?.name ?? ''),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Criado em ${Functions(date: item?.createdAt).formatDate}'),
                  Text(
                      'Total: ${Functions(number: item?.totalCost).getMoney()}')
                ],
              ),
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: const Text('Ingredientes'),
                children: item?.ingredients?.map((e) => ListTile(
                  leading: const Icon(Icons.label),
                  title: Text(e?.name ?? ''),
                  subtitle: Text('${Functions(number: e?.cost).getMoney()}'),
                  trailing: Text('${e?.quantityInPackage} ${e?.unitOfMeasurement}'),
                )).toList() ?? [],
              ),
            )
          ],
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
      ReceiptsController.load();
      Get.rawSnackbar(
          snackbarStatus: (value) {
            switch (value) {
              case SnackbarStatus.CLOSED:
                ReceiptsController.load();
                break;
              default:
                break;
            }
          },
          message:
              'Item foi excluido com sucesso, caso queira restaurar clique aqui.',
          duration: const Duration(seconds: 5),
          onTap: (_) async {
            final r = await ReceiptsController.post(newData: req.data);
            if (!r.result) {
              Get.defaultDialog(title: 'Atenção', middleText: r.message);
            }
          });
    }
  }

  void changeIndex(int value, {Receipts? receipt}) {
    if (value == 0) {
      recepForm.selectedReceipt.value = null;
    } else {
      recepForm.selectedReceipt.value = receipt;
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
    ReceiptsController.load();
    super.initState();
  }
}
