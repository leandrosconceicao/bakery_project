

import 'package:bakery/libraries/utils.dart';

import '../../../libraries/models.dart';
import '../../../libraries/views.dart';

class IngredientManager extends StatefulWidget {
  final bool isEdit;
  final Ingredients? data;
  const IngredientManager({super.key, this.isEdit=false, this.data});

  @override
  State<IngredientManager> createState() => _IngredientManagerState();
}

class _IngredientManagerState extends State<IngredientManager> {

  @override
  void initState() {
    ingreForm.fillForm(widget.data);
    super.initState();
  }

  @override
  void dispose() {
    ingreForm.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  focusNode: ingreForm.nameFcs,
                  controller: ingreForm.name,
                  decoration: const InputDecoration(
                    labelText: 'Nome'
                  ),
                )),
              SizedBox(width: Get.height * 0.01,),
              Expanded(child: TextFormField(
                controller: ingreForm.cost,
                focusNode: ingreForm.costFcs,
                decoration: const InputDecoration(
                  labelText: 'Custo'
                ),
              ))
            ],
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: ingreForm.qtdPackage,
                  focusNode: ingreForm.qtdFcs,
                  decoration: const InputDecoration(
                  labelText: 'Qtd. embalagem'
                ),),
              ),
              SizedBox(width: Get.height * 0.01,),
              Expanded(
                child: TextFormField(
                  controller: ingreForm.unit,
                  focusNode: ingreForm.unitFcs,
                  decoration: const InputDecoration(
                    labelText: 'Unidade'
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

// cost: 0,
// name: '',
// quantityInPackage: 0,
// storeCode: '',
// unitOfMeasurement: '',

