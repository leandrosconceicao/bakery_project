import '../../libraries/models.dart';
import '../../libraries/utils.dart';

final expansesControl = ExpansesController();

class ExpansesController {
  final bloc = StreamController<ApiRes<List<Expanses?>>>.broadcast();

  void load({bool? clearValues = true}) async {
    // if (clearValues!) {
    //   bloc.add(null);
    // }
    bloc.add(await findAll());
  }

  Future<ApiRes<List<Expanses?>>> findAll() async {
    final req = await Api.request<List<Expanses?>>(
        method: ApiMethods.get,
        endpoint: '${Endpoints.bakeryExpanses}?storeCode=${app.storeCode}',
        function: Expanses.toList);
    return req;
  }

  Future<ApiRes> post({Expanses? newData}) async {
    final map = newData?.toJson();
    final req = await Api.request(
        method: ApiMethods.post, endpoint: Endpoints.bakeryExpanses, body: map);
    return req;
  }

  Future<ApiRes<Expanses?>> delete({Expanses? data}) {
    final map = {"id": data?.id};
    final req = Api.request<Expanses?>(
      method: ApiMethods.del,
      endpoint: Endpoints.bakeryExpanses,
      body: map,
    );
    return req;
  }

  Future<ApiRes> update({String? id}) async {
    final map = {
      "id": id,
      "data": {
        "description": expanseForm.desc.text,
        "value": expanseForm.getValue,
      }
    };
    final req = await Api.request(
      method: ApiMethods.put,
      endpoint: Endpoints.bakeryExpanses,
      body: map,
    );
    return req;
  }
}
