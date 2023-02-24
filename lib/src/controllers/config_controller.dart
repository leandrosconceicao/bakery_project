import '../../libraries/models.dart';
import '../../libraries/utils.dart';

class ConfigController {
  static final bloc = StreamController<ApiRes<Configs?>?>.broadcast();

  static Future<void> load({bool? clearValues = true}) async {
    if (clearValues!) {
      bloc.add(null);
    }
    bloc.add(await findAll());
  }

  static Future<ApiRes<Configs?>> findAll() async {
    final req = await Api.request<Configs?>(
        method: ApiMethods.get,
        endpoint: '${Endpoints.bakeryConfigs}/${app.storeCode}',
        function: Configs.fromJson);
    if (req.result) {
      app.defaultConfig.value = req.data;
      confForm.dayOfWorkPerMonth.text = req.data?.daysOfWork.toString() ?? '';
      confForm.averageGain.text = req.data?.averageGain?.toStringAsFixed(2) ?? '';
      confForm.hoursOfWorkPerDay.text = req.data?.hoursPerDay.toString() ?? '';
    }
    return req;
  }

  static Future<ApiRes> post({Configs? data}) async {
    final req = await Api.request(
      method: ApiMethods.post,
      endpoint: Endpoints.bakeryConfigs,
      body: data?.toJson(),
    );
    return req;
  }

  static Future<ApiRes<List<Configs?>>> delete({Configs? data}) async {
    final req = await Api.request<List<Configs?>>(
      method: ApiMethods.del,
      endpoint: Endpoints.bakeryConfigs,
      body: {"_id": data?.id},
      function: Configs.toList
    );
    return req;
  }

  static Future<ApiRes> update({required String id, Configs? data}) async {
    final params = {
        "_id": id,
        "data": data?.toJson()
      };
    final req = await Api.request(
      method: ApiMethods.put,
      endpoint: Endpoints.bakeryConfigs,
      body: params
    );
    return req;
  }
}
