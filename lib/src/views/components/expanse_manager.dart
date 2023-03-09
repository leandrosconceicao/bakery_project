import 'package:bakery/libraries/controllers.dart';

import '../../../libraries/models.dart';
import '../../../libraries/utils.dart';
import '../../../libraries/views.dart';

class ExpanseManager extends StatelessWidget {
  final void Function()? onReturn;
  final bool? isEdit;
  final Expanses? value;
  const ExpanseManager({
    super.key,
    this.onReturn,
    this.isEdit,
    this.value
  });

  @override
  Widget build(BuildContext context) {
    onEdit();
    return AlertDialog(
      title: Text((isEdit ?? false) ? 'Editando despesa' : 'Nova despesa'),
      content: SingleChildScrollView(
        child: Form(
          key: expanseForm.key,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                controller: expanseForm.desc,
                focusNode: expanseForm.descFcs,
                onFieldSubmitted: (_) => expanseForm.valueFcs.requestFocus(),
                decoration:
                    const InputDecoration(labelText: 'Descrição', filled: true),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Obrigatório' : null,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              TextFormField(
                controller: expanseForm.value,
                focusNode: expanseForm.valueFcs,
                onFieldSubmitted: (_) async => await onSaveFunction(),
                decoration:
                    const InputDecoration(labelText: 'Valor', filled: true),
                validator: (value) =>
                    (num.tryParse(value!) ?? 0.0) <= 0 ? 'Inválido' : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: LoadingButton(
                label: const Text('Confirmar'),
                process: () async {
                  await onSaveFunction();
                },
              ),
            ),
            Expanded(
                child: TextButton(
                    onPressed: onCancel, child: const Text('Cancelar')))
          ],
        )
      ],
    );
  }

  Future<void> onSaveFunction() async {
    if (expanseForm.key.currentState!.validate()) {
      late ApiRes req;
      if (isEdit ?? false) {
        req = await expansesControl.update(id: value?.id);
      } else {
        req = await expansesControl.post(
          newData: Expanses(
          description: expanseForm.desc.text,
          value: expanseForm.getValue,
        ));
      }
      if (!req.result) {
        Get.defaultDialog(middleText: req.message, title: 'Atenção');
      } else {
        Get.back();
        expansesControl.load();
        expanseForm.clearForm();
      }
    }
  }

  void onCancel() {
    Get.back();
    expanseForm.clearForm();
  }
  
  void onEdit() {
    if (isEdit ?? false) {
      expanseForm.desc.text = value?.description ?? '';
      expanseForm.value.text = (value?.value ?? 0.00).toStringAsFixed(2);
    }
  }
}
