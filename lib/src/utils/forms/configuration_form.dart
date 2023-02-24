import 'package:bakery/libraries/views.dart';

import '/libraries/utils.dart';

class ConfigurationForm {
  final dayOfWorkPerMonth = MaskedTextController(mask: '@@');
  final hoursOfWorkPerDay = MaskedTextController(mask: '@@');
  final averageGain = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '');

  final daysFcs = FocusNode();
  final hoursFcs = FocusNode();
  final gainFcs = FocusNode();
  final btnFcs = FocusNode();

  num? days() {
    return num.tryParse(dayOfWorkPerMonth.text);
  }

  num? hours() {
    return num.tryParse(hoursOfWorkPerDay.text);
  }

  num? gain() {
    return num.tryParse(averageGain.text.replaceAll(',', '.'));
  }

  void clear() {
    dayOfWorkPerMonth.clear();
    hoursOfWorkPerDay.clear();
    averageGain.clear();
  }
}

final confForm = ConfigurationForm();