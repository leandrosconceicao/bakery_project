import '../../../libraries/utils.dart';

class Functions {

  DateTime? date;
  num? number;
  Functions({this.date, this.number});

  Money getMoney() {
    final brl = Currency.create('BRL', 2, symbol: 'R\$');
    return Money.fromNum(number ?? 0, code: brl.code);
  }

  String formatDate() {
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(date ?? DateTime.now());
  }

}