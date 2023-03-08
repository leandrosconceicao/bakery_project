import 'package:bakery/libraries/views.dart';

import '../../../libraries/models.dart';

class ReceiptForm {
  final selectedIngredients = RxList<Ingredients?>();
  final selectedReceipt = Rxn<Receipts?>();

  final name = TextEditingController();
  final nameFcs = FocusNode();

  void clearData() {
    recepForm.name.clear();
    recepForm.selectedIngredients.clear();
    recepForm.selectedReceipt.value = null;
  }
}

final recepForm = ReceiptForm();