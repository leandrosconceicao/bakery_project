import '../../../libraries/controllers.dart';
import '../../../libraries/models.dart';
import '../../../libraries/utils.dart';
import '../../../libraries/views.dart';

class ExpensesView extends StatefulWidget {
  const ExpensesView({super.key});

  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView> {
  final title = 'Despesas';

  @override
  Widget build(BuildContext context) {
    return DefaultPage(title: title, child: _body());
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
            child: AppBlocBuilder<List<Expanses?>>(
                bloc: expansesControl.bloc, child: dataList)),
        FloatingActionButton(
          onPressed: () {
            Get.dialog(const ExpanseManager());
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: Get.height * 0.1,
        )
      ],
    );
  }

  Widget dataList(List<Expanses?>? data) {
    if (data?.isEmpty ?? true) {
      return const NotFoundWarning(message: 'Nenhuma despesa cadastrada\nno momento',);
    }
    return ListView.separated(
      separatorBuilder: (context, _) => const Divider(),
      itemCount: data!.length,
      itemBuilder: (context, int i) {
        final item = data[i];
        return ListTile(
          leading: const Icon(
            Icons.monetization_on,
            size: 40,
          ),
          title: Text(item?.description ?? ''),
          trailing: OptionsButton(
            icon: const Icon(Icons.settings),
            actionsData: [
              ActionsData(value: ActionTypes.edit, title: 'Editar'),
              ActionsData(value: ActionTypes.del, title: 'Excluir')
            ],
            onSelected: (value) {
              switch (value) {
                case ActionTypes.edit:
                  onEdit(data: item);
                  break;
                case ActionTypes.del:
                  onDel(value: item);
                  break;
                default:
                  break;
              }
            },
          ),
          subtitle: Text('${Functions(number: item?.value).getMoney()}\n${Functions(date: item?.createdAt).formatDate}'),
        );
      },
    );
  }

  @override
  void initState() {
    expansesControl.load();
    super.initState();
  }
  
  void onEdit({Expanses? data}) {
    Get.dialog(ExpanseManager(isEdit: true, value: data));
  }
  
  void onDel({Expanses? value}) {
    Get.dialog(
      AlertDialog(
        title: const Text('Atenção!'),
        content: const Text('Confirma a exclusão dos dados?'),
        actions: [
          LoadingButton(label: const Text('Sim'), process: () async {
            final req = await expansesControl.delete(data: value);
            if (!req.result) {
              Get.defaultDialog(middleText: req.message, title: 'Atenção');
            } else {
              Get.back();
              expansesControl.load();
            }
          }),
          TextButton(onPressed: () => Get.back(), child: const Text('Não'))
        ],
      ),
      barrierDismissible: false
    );
  }
}
