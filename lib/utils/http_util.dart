import 'dart:async';
import 'package:dio/dio.dart';
import 'package:my_weather_assist/config/app_config.dart';

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;

  late Dio dio;
  CancelToken cancelToken = new CancelToken();

  HttpUtil._internal() {
    BaseOptions options = new BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      headers: {},
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );
    dio = new Dio(options);
  }

  dynamic _adapterData(dynamic data) {
    return data;
  }

  /// get
  Future get(String path) async {
    try {
      var response = await dio.get(
        path,
      );
      return _adapterData(response.data);
    } on DioError catch (e) {
      print(e);
    }
  }
}
