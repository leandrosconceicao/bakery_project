import 'package:bakery/src/controllers/expanses_controller.dart';

import '../../../libraries/models.dart';
import '../../../libraries/utils.dart';
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
      children: [
        Column(
          children: [
            Expanded(child: AppBlocBuilder<List<Expanses?>>(bloc: expansesControl.bloc, child: dataList))
          ],
        )
      ],
    );
  }

  Widget dataList(List<Expanses?>? data) {
    if (data?.isEmpty ?? true) {
      return const NotFoundWarning();
    }
    return ListView.builder(
      itemCount: data!.length,
      itemBuilder: (context, int i) {
        final item = data[i];
        return ListTile(
          leading: const Icon(Icons.monetization_on, size: 40,),
          title: Text(item?.description ?? ''),
          trailing: Text('${Functions(number: item?.value).getMoney()}'),
          subtitle: Text(Functions(date: item?.createdAt).formatDate),
        );
      },
    );
  }

  @override
  void initState() {
    tab = TabController(length: 3, vsync: this);
    expansesControl.load();
    super.initState();
  }
}
