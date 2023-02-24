import '../../libraries/models.dart';
import '../../libraries/utils.dart';
import 'package:http/http.dart' as http;

enum ApiMethods { get, post, put, patch, del }

class Api<T> {
  static Future<ApiRes<T>> request<T>({
    required ApiMethods method,
    required String endpoint,
    int? timeout,
    Function? function,
    Object? body,
  }) async {
    try {
      final http.Response res;
      switch (method) {
        case ApiMethods.get:
          res = await Api._get(endpoint, timeout ?? 10);
          return ApiRes.parseData<T>(res.bodyBytes, parser: function);
        case ApiMethods.post:
          res = await Api._post(endpoint, timeout ?? 10, body: body);
          // if (endpoint == Endpoints.authentication) {
          //   headers['authorization'] = res.headers['authorization'] ?? '';
          // }
          return ApiRes.parseData<T>(res.bodyBytes, parser: function);
        case ApiMethods.put:
          res = await Api._put(endpoint, timeout ?? 10, body: body);
          return ApiRes.parseData<T>(res.bodyBytes, parser: function);
        case ApiMethods.patch:
          res = await Api._patch(endpoint, timeout ?? 10, body: body);
          return ApiRes.parseData<T>(res.bodyBytes, parser: function);
        case ApiMethods.del:
          res = await Api._del(endpoint, timeout ?? 10, body: body);
          return ApiRes.parseData<T>(res.bodyBytes, parser: function);
      }
    } on http.ClientException {
      return ApiRes.connError();
    } on SocketException {
      return ApiRes.socketError();
    } on TimeoutException {
      return ApiRes.timeout();
    } catch (e) {
      return ApiRes.unknow(err: e);
    }
  }

  static Future<http.Response> _get(String endpoint, int time) async {
    return await http
        .get(Uri.parse('${app.requestUrl}$endpoint'), headers: app.headers)
        .timeout(Duration(seconds: time));
  }

  static Future<http.Response> _post(String endpoint, int time,
      {dynamic body}) async {
    return await http
        .post(
          Uri.parse('${app.requestUrl}$endpoint'),
          body: body != null ? json.encode(body) : null,
          headers: app.headers,
        )
        .timeout(Duration(seconds: time));
  }

  static Future<http.Response> _put(String endpoint, int time,
      {dynamic body}) async {
    return await http
        .put(
          Uri.parse('${app.requestUrl}$endpoint'),
          body: body != null ? json.encode(body) : null,
          headers: app.headers,
        )
        .timeout(Duration(seconds: time));
  }

  static Future<http.Response> _del(String endpoint, int time,
      {dynamic body}) async {
    return await http
        .delete(
          Uri.parse('${app.requestUrl}$endpoint'),
          body: body != null ? json.encode(body) : null,
          headers: app.headers,
        )
        .timeout(Duration(seconds: time));
  }

  static Future<http.Response> _patch(String endpoint, int time,
      {dynamic body}) async {
    return await http
        .patch(
          Uri.parse('${app.requestUrl}$endpoint'),
          body: body != null ? json.encode(body) : null,
          headers: app.headers,
        )
        .timeout(Duration(seconds: time));
  }
}
