
import '../../../libraries/controllers.dart';
import '../../../libraries/models.dart';
import '/libraries/utils.dart';

import '../../../libraries/views.dart';

class Config extends StatefulWidget {
  const Config({super.key});

  @override
  State<Config> createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    ConfigController.load();
    super.initState();
  }

  @override
  void dispose() {
    confForm.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Configurações';
    return DefaultPage(
      title: title,
      appBarTitle: const Text(title),
      child: Center(child: _body()),
    );
  }

  Widget _body() {
    return StreamBuilder(
      stream: ConfigController.bloc.stream,
      builder: (context, AsyncSnapshot<ApiRes<Configs?>?> snap) {
        return SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                      height: Get.height * 0.25,
                      child: Image.asset('${app.staticFolder}/finance.jpg')),
                  NumberField(
                    'Dias de trabalho por mês',
                    controller: confForm.dayOfWorkPerMonth,
                    focus: confForm.daysFcs,
                    inputType: TextInputType.number,
                    validator: defaultValidator,
                    onFieldSubmitted: (_) => confForm.hoursFcs.requestFocus()
                  ),
                  NumberField(
                    'Horas de trabalho por dia',
                    controller: confForm.hoursOfWorkPerDay,
                    focus: confForm.hoursFcs,
                    inputType: TextInputType.number,
                    validator: defaultValidator,
                    onFieldSubmitted: (_) => confForm.gainFcs.requestFocus()
                    
                  ),
                  NumberField(
                    'Meta de ganho mensal',
                    controller: confForm.averageGain,
                    focus: confForm.gainFcs,
                    inputType: TextInputType.number,
                    validator: defaultValidator,
                    onFieldSubmitted: (_) => confForm.btnFcs.requestFocus()
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Text('Mão de obra/hora: ${app.defaultConfig.value?.getAverageGain() ?? ''}', style: Get.textTheme.headlineMedium,),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  SizedBox(
                    width: Get.width,
                    height: Get.height * 0.05,
                    child: LoadingButton(
                      focus: confForm.btnFcs,
                      label: Text(
                        'Salvar',
                        style: Get.textTheme.headlineSmall,
                      ),
                      process: saveFunc,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String? defaultValidator(String? value) {
    return (value?.isEmpty ?? true) ? 'Obrigatório' : null;
  }

  Future<void> saveFunc() async {
    if (formKey.currentState?.validate() ?? false) {
      final req = await ConfigController.post(
        data: Configs(
          storeCode: app.storeCode,
          daysOfWork: confForm.days(),
          averageGain: confForm.gain(),
          hoursPerDay: confForm.hours(),
        ),
      );
      if (!req.result) {
        Get.defaultDialog(middleText: req.message);
      } else {
        Get.rawSnackbar(message: 'Dados salvos com sucesso!');
        ConfigController.load();
      }
    }
  }
}
