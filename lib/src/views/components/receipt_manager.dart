import '/libraries/controllers.dart';

import '../../../libraries/utils.dart';
import '../../../libraries/models.dart';
import '../../../libraries/views.dart';

class ReceiptManager extends StatefulWidget {
  final TabController tabController;
  const ReceiptManager({super.key, required this.tabController});

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
              focusNode: recepForm.nameFcs,
              validator: (value) =>
                  (value?.isEmpty ?? true) ? 'Obrigatório' : null,
              controller: recepForm.name,
              decoration:
                  const InputDecoration(filled: true, labelText: 'Descrição'),
              onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
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
          ],
        ),
      ),
    );
  }

  Widget itemsList(List<Ingredients?>? ingredientsData) {
    if (ingredientsData?.isEmpty ?? true) {
      return const NotFoundWarning();
    }
    return Column(
      children: [
        const ListTile(
          leading: Icon(Icons.soup_kitchen),
          title: Text('Selecione os Ingredientes'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: ingredientsData?.length,
            itemBuilder: (context, int i) {
              final item = ingredientsData?[i];
              // final check = validators[i];
              return Obx(
                () => SizedBox(
                  width: 400,
                  child: CheckboxListTile(
                    activeColor: MyPallete.defaultColor,
                    title: Text(item?.name ?? ''),
                    value: item?.selected?.value,
                    onChanged: (bool? value) {
                      item?.selected?.value = value!;
                      if (value!) {
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
        late ApiRes req;
        if (recepForm.selectedReceipt.value == null) {
          req = await ReceiptsController.post(
            newData: Receipts(
                storeCode: app.storeCode!,
                name: recepForm.name.text,
                ingredients: recepForm.selectedIngredients),
          );
        } else {
          final recipe = recepForm.selectedReceipt.value;
          recipe?.ingredients = recepForm.selectedIngredients;
          req = await ReceiptsController.update(
            id: recepForm.selectedReceipt.value!.id!,
            data: recipe,
          );
        }
        if (!req.result) {
          Get.defaultDialog(middleText: req.message);
        } else {
          Get.rawSnackbar(message: 'Receita ${recepForm.selectedReceipt.value != null ? 'editada' : 'salva'} com sucesso');
          tbControl.animateTo(0);
          ReceiptsController.load();
        }
      }
    }
  }

  @override
  void initState() {
    recepForm.nameFcs.requestFocus();
    if (recepForm.selectedReceipt.value != null) {
      recepForm.name.text = recepForm.selectedReceipt.value?.name ?? '';
    }
    IngredientsController.load();
    super.initState();
  }

  @override
  void dispose() {
    recepForm.clearData();
    super.dispose();
  }
}

// String? name;
// DateTime? createdAt;
// List<Ingredients?>? ingredients;
