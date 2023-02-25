import 'package:bakery/libraries/views.dart';

import '/libraries/utils.dart';

class IngredientsForm {
  final cost = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '');
  final qtdPackage = TextEditingController();
  final name = TextEditingController();
  final unit = TextEditingController();

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
}

final ingreForm = IngredientsForm();

// cost: 0,
// name: '',
// quantityInPackage: 0,
// storeCode: '',
// unitOfMeasurement: '',