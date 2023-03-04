import '/libraries/views.dart';

class ExpensesView extends StatefulWidget {
  const ExpensesView({super.key});

  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView> with SingleTickerProviderStateMixin {

  final title = 'Despesas';
  late final TabController tab;

  @override
  Widget build(BuildContext context) {
    return DefaultPage(
      title: title,
      child: _body()
    );
  }

  Widget _body() {
    return TabBarView(
      controller: tab,
      children: [],
    );
  }

  @override
  void initState() {
    tab = TabController(length: 3, vsync: this);
    super.initState();
  }
}
