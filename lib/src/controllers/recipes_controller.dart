import '../../libraries/models.dart';
import '../../libraries/utils.dart';

class ReceiptsController {
  static final bloc = StreamController<ApiRes<List<Receipts?>>>.broadcast();

  static Future<void> load({bool? clearValues = true}) async {
    // if (clearValues!) {
    //   bloc.add(null);
    // }
    bloc.add(await findAll());
  }

  static Future<ApiRes<List<Receipts?>>> findAll() async {
    final req = await Api.request<List<Receipts?>>(
      method: ApiMethods.get,
      endpoint: '${Endpoints.bakeryRecipes}?storeCode=${app.storeCode}',
      function: Receipts.toList,
    );
    return req;
  }

  static Future<ApiRes> post({Receipts? newData}) async {
    final req = await Api.request(
        method: ApiMethods.post,
        endpoint: Endpoints.bakeryRecipes,
        body: newData?.toJson());
    return req;
  }

  static Future<ApiRes<List<Receipts?>>> delete({Receipts? data}) async {
    final req = await Api.request<List<Receipts?>>(
        method: ApiMethods.del,
        endpoint: Endpoints.bakeryRecipes,
        body: {"_id": data?.id},
        function: Receipts.toList);
    return req;
  }

  static Future<ApiRes> update({required String id, Receipts? data}) async {
    final params = {
        "_id": id,
        "data": data?.toJson()
      };
    final req = await Api.request(
      method: ApiMethods.put,
      endpoint: Endpoints.bakeryRecipes,
      body: params
    );
    return req;
  }
}
