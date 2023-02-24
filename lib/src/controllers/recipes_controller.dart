import '../../libraries/models.dart';
import '../../libraries/utils.dart';

class RecipesController {
  static final bloc = StreamController<ApiRes<List<Recipes?>>?>.broadcast();

  static Future<void> load({bool? clearValues = true}) async {
    if (clearValues!) {
      bloc.add(null);
    }
    bloc.add(await findAll());
  }

  static Future<ApiRes<List<Recipes?>>> findAll() async {
    final req = await Api.request<List<Recipes?>>(
      method: ApiMethods.get,
      endpoint: '${Endpoints.bakeryRecipes}?storeCode=${app.storeCode}',
      function: Recipes.toList,
    );
    return req;
  }

  static Future<ApiRes> post({Recipes? newData}) async {
    final req = await Api.request(
        method: ApiMethods.post,
        endpoint: Endpoints.bakeryRecipes,
        body: newData?.toJson());
    return req;
  }

  static Future<ApiRes<List<Recipes?>>> delete({Recipes? data}) async {
    final req = await Api.request<List<Recipes?>>(
        method: ApiMethods.del,
        endpoint: Endpoints.bakeryRecipes,
        body: {"_id": data?.id},
        function: Recipes.toList);
    return req;
  }

  static Future<ApiRes> update({required String id, Recipes? data}) async {
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
