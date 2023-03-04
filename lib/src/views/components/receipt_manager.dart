import '/libraries/controllers.dart';

import '../../../libraries/utils.dart';
import '../../../libraries/models.dart';
import '../../../libraries/views.dart';

class ReceiptManager extends StatefulWidget {
  final Receipts? data;
  final TabController tabController;
  const ReceiptManager({super.key, this.data, required this.tabController});

  @override
  State<ReceiptManager> createState() => _ReceiptManagerState();
}

class _ReceiptManagerState extends State<ReceiptManager> {
  TabController get tbControl => widget.tabController;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              children: [
                TextButton.icon(
                    onPressed: () {
                      tbControl.animateTo(0);
                      ReceiptsController.load();
                    },
                    icon: const Icon(CupertinoIcons.chevron_back),
                    label: const Text('Voltar'))
              ],
            ),
            TextFormField(
              validator: (value) => (value?.isEmpty ?? true) ? 'Obrigatório' : null,
              controller: recepForm.name,
              decoration: const InputDecoration(filled: true, labelText: 'Descrição'),
              onFieldSubmitted: (_) => saveFunc(),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Expanded(
              child: AppBlocBuilder<List<Ingredients?>>(
                  bloc: IngredientsController.bloc, child: itemsList),
            ),
            Obx(
              () => Visibility(
                visible: recepForm.selectedIngredients.isNotEmpty,
                child: SizedBox(
                  height: Get.height * 0.06,
                  width: double.infinity,
                  child: LoadingButton(
                    label: const Text('Salvar'),
                    process: () => saveFunc(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.09,
            )
          ],
        ),
      ),
    );
  }

  Widget itemsList(List<Ingredients?>? data) {
    if (data?.isEmpty ?? true) {
      return const NotFoundWarning();
    }
    final validators = List.generate(data!.length, (index) => false.obs);
    return Column(
      children: [
        const ListTile(
          leading: Icon(Icons.soup_kitchen),
          title: Text('Selecione os Ingredientes'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, int i) {
              final item = data[i];
              final check = validators[i];
              return Obx(
                () => SizedBox(
                  width: 400,
                  child: CheckboxListTile(
                    activeColor: MyPallete.defaultColor,
                    title: Text(item?.name ?? ''),
                    value: check.value,
                    onChanged: (bool? value) {
                      check.value = value!;
                      if (value) {
                        if (!recepForm.selectedIngredients.contains(item)) {
                          recepForm.selectedIngredients.add(item);
                        } else {
                          recepForm.selectedIngredients.remove(item);
                        }
                      } else {
                        recepForm.selectedIngredients.remove(item);
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> saveFunc() async {
    if (formKey.currentState!.validate()) {
      if (recepForm.selectedIngredients.isEmpty) {
        Get.defaultDialog(middleText: 'Selecione os ingredientes');
      } else {
        final req = await ReceiptsController.post(
        newData: Receipts(
            storeCode: app.storeCode!,
            name: recepForm.name.text,
            ingredients: recepForm.selectedIngredients),
        );
        if (!req.result) {
          Get.defaultDialog(middleText: req.message);
        } else {
          Get.rawSnackbar(message: 'Receita salva com sucesso');
          tbControl.animateTo(0);
        }
      }
    }
  }

  @override
  void initState() {
    if (widget.data != null) {
      // recepForm.selectedIngredients.ad;
    }
    IngredientsController.load();
    super.initState();
  }

  @override
  void dispose() {
    recepForm.name.clear();
    recepForm.selectedIngredients.clear();
    super.dispose();
  }
}

// String? name;
// DateTime? createdAt;
// List<Ingredients?>? ingredients;
