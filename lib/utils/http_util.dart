import 'dart:async';
import 'package:dio/dio.dart';

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() => _instance;

  late Dio dio;
  CancelToken cancelToken = new CancelToken();

  HttpUtil._internal() {
    BaseOptions options = new BaseOptions(
      // baseUrl: getApiUrl(),
      connectTimeout: 30000,
      receiveTimeout: 30000,
      headers: {},
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );
    dio = new Dio(options);
  }

  // error types
  ErrorEntity createErrorEntity(DioError error) {
    print("createErrorEntity ");
    print("${error.message} ${error.type}");
    switch (error.type) {
      case DioErrorType.cancel:
        {
          return ErrorEntity(
              code: error.response?.statusCode,
              message: "Request Cancelled"); //cancel
        }
      case DioErrorType.connectTimeout:
        {
          return ErrorEntity(
              code: error.response?.statusCode,
              message: "Connection Timeout"); //connection time out
        }
      case DioErrorType.sendTimeout:
        {
          return ErrorEntity(
              code: error.response?.statusCode,
              message: "Request Timeout"); //request time out
        }
      case DioErrorType.receiveTimeout:
        {
          return ErrorEntity(
              code: error.response?.statusCode,
              message: "Response Timeout"); //response time out
        }
      case DioErrorType.response:
        {
          try {
            int errCode = error.response?.statusCode ?? -1;
            switch (errCode) {
              case 400:
                {
                  return ErrorEntity(
                      code: errCode,
                      message: "Request Syntax Error"); //Request Syntax Error
                }
              case 401:
                {
                  return ErrorEntity(
                      code: errCode, message: "No Permission"); //no permission
                }
              case 403:
                {
                  return ErrorEntity(
                      code: errCode,
                      message:
                          "Server Rejected Executing"); //Server Rejected Executing
                }
              case 404:
                {
                  return ErrorEntity(
                      code: errCode,
                      message:
                          "Unable to Connect to Server"); //Unable to Connect to Server
                }
              case 405:
                {
                  return ErrorEntity(
                      code: errCode,
                      message:
                          "Request Method was Baned"); //Request Method was Baned
                }
              case 500:
                {
                  return ErrorEntity(
                      code: errCode,
                      message: "Server Internal Error"); //Server Internal Error
                }
              case 502:
                {
                  return ErrorEntity(
                      code: errCode,
                      message: "Invalid Request"); //Invalid Request
                }
              case 503:
                {
                  return ErrorEntity(
                      code: errCode,
                      message: "Server is Down"); //Server is Down
                }
              case 505:
                {
                  return ErrorEntity(
                      code: errCode,
                      message:
                          "Unsupported HTTP Protocol Request"); //Unsupported HTTP Protocol Request
                }
              default:
                {
                  // return ErrorEntity(code: errCode, message: "unknown error");
                  return ErrorEntity(
                      code: errCode,
                      message: error.response?.statusMessage ?? '');
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(
                code: -1, message: "Unknown Error"); //Unknown Error
          }
        }
      default:
        {
          return ErrorEntity(code: -1, message: error.message);
        }
    }
  }

  dynamic _adapterData(dynamic data) {
    print("_adapterData org_data is " + data.toString());

    Map<String, dynamic> orgData = data;

    String status = orgData["status"];
    String message = '';
    if (status == 'OK') {
      return data;
    } else {
      message = orgData["error_message"];
    }
    print("_adapterData Error $status with $message");
    ErrorEntity e = ErrorEntity(code: 400, message: message);
    throw e;
  }

  /// restful get
  Future get(
    String path, {
    dynamic params,
  }) async {
    try {
      var response = await dio.get(
        path,
        queryParameters: params,
      );
      return _adapterData(response.data);
    } on DioError catch (e) {
      print(e);
      throw createErrorEntity(e);
    }
  }
}

/// error handler
class ErrorEntity implements Exception {
  int? code;
  String? message;
  ErrorEntity({this.code, this.message}) {
    code = code;
    message = message;
  }

  String toString() {
    if (message == null) return "Exception: code $code";
    return "$message";
  }
}
