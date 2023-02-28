import 'package:bakery/libraries/views.dart';

import '../../../libraries/models.dart';
import '/libraries/utils.dart';

class IngredientsForm {
  final cost = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '');
  final qtdPackage = TextEditingController();
  final name = TextEditingController();
  final unit = TextEditingController();

  final costFcs = FocusNode();
  final qtdFcs = FocusNode();
  final nameFcs = FocusNode();
  final unitFcs = FocusNode();

  num getCost() {
    return num.tryParse(cost.text.replaceAll(',', '.')) ?? 0.0;
  }

  String getName() {
    return name.text;
  }

  num getQtdPkg() {
    return num.tryParse(qtdPackage.text) ?? 0;
  }

  String getUnit() {
    return unit.text;
  }

  void fillForm(Ingredients? data) {
    cost.text = data?.cost?.toStringAsFixed(2) ?? '';
    qtdPackage.text = data?.quantityInPackage.toString() ?? '';
    name.text = data?.name ?? '';
    unit.text = data?.unitOfMeasurement ?? '';
  }

  void clear() {
    cost.clear();
    qtdPackage.clear();
    name.clear();
    unit.clear();
  }
}

final ingreForm = IngredientsForm();

// cost: 0,
// name: '',
// quantityInPackage: 0,
// storeCode: '',
// unitOfMeasurement: '',