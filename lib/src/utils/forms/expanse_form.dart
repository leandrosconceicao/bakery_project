import '../../../libraries/views.dart';
import '../../../libraries/utils.dart';

final expanseForm = ExpanseForm();

class ExpanseForm {
  final desc = TextEditingController();
  final descFcs = FocusNode();
  final value =
      MoneyMaskedTextController(
        initialValue: 0.0,
        decimalSeparator: '.', thousandSeparator: '');

  final valueFcs = FocusNode();

  final key = GlobalKey<FormState>();

  num get getValue => num.tryParse(value.text) ?? 0.0;

  void clearForm() {
    desc.clear();
    value.text = '0.00';
  }
}
