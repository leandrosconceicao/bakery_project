import '../../libraries/models.dart';
import '../../libraries/utils.dart';

class IngredientsController {
  static final bloc = StreamController<ApiRes<List<Ingredients?>>>.broadcast();

  static Future<void> load() async {
    // if (clearValues!) {
    //   bloc.add(null);
    // }
    bloc.add(await findAll());
  }

  static Future<ApiRes<List<Ingredients?>>> findAll() async {
    final req = await Api.request<List<Ingredients?>>(
        method: ApiMethods.get,
        endpoint: '${Endpoints.bakeryIngredients}?storeCode=${app.storeCode}',
        function: Ingredients.toList);
    return req;
  }

  static Future<ApiRes> post(Ingredients newData) async {
    final req = await Api.request(
        method: ApiMethods.post,
        endpoint: Endpoints.bakeryIngredients,
        body: newData.toJson());
    return req;
  }

  static Future<ApiRes> update({required String id, Ingredients? data}) async {
    final params = {
        "_id": id,
        "data": data?.toJson()
      };
    final req = await Api.request(
      method: ApiMethods.put,
      endpoint: Endpoints.bakeryIngredients,
      body: params
    );
    return req;
  }

  static Future<ApiRes<List<Ingredients?>>> delete({Ingredients? data}) async {
    final req = await Api.request<List<Ingredients?>>(
      method: ApiMethods.del,
      endpoint: Endpoints.bakeryIngredients,
      body: {"_id": data?.id},
      function: Ingredients.toList,
    );
    return req;
  }
}
