import '../../libraries/models.dart';
import '../../libraries/utils.dart';

final expansesControl = ExpansesController();

class ExpansesController {
  
  final bloc = StreamController<ApiRes<List<Expanses?>>>.broadcast();

  void load({bool? clearValues=true}) async {
    // if (clearValues!) {
    //   bloc.add(null);
    // }
    bloc.add(await findAll());
  }

  Future<ApiRes<List<Expanses?>>> findAll() async {
    final req = await Api.request<List<Expanses?>>(
      method: ApiMethods.get,
      endpoint: '${Endpoints.expanses}?storeCode=${app.storeCode}',
      function: Expanses.toList
    );
    return req;
  }

  Future<ApiRes> post() async {
    final req = await Api.request(
      method: ApiMethods.post,
      endpoint: Endpoints.expanses,
    );
    return req;
  }

}
