import 'dart:async';

import 'package:dio/dio.dart';

class HttpCore {
  static const GET = "get";
  static const POST = "post";

  factory HttpCore() {
    if (_instance == null) _instance = HttpCore._internal();
    return _instance;
  }

  HttpCore._internal();

  static HttpCore _instance;

  static HttpCore get instance => HttpCore();

  var dio = Dio(BaseOptions(connectTimeout: 10000, receiveTimeout: 30000));

  Future<Response> get(String url, {Map params, Function errorCallback}) async {
    return _request(url, params: params, method: GET, errorCallback: errorCallback);
  }

  Future<Response> post(String url, {Map params, Function errorCallback}) async {
    return _request(url, params: params, method: POST, errorCallback: errorCallback);
  }

  Future<Response> download(String urlPath, String savePath,
      {ProgressCallback progressBack, Function errorCallback}) async {
    Response response;

    try {
      response = await dio.download(urlPath, savePath, onReceiveProgress: progressBack);

      if (response.statusCode != 200) {
        _handleMessage(errorCallback, 'network error:: errorcode => ${response.statusCode}');
        return null;
      }
      return response;
    } catch (exception) {
      _handleMessage(errorCallback, exception.toString());
      return null;
    }
  }

  Future<Response> _request(String url, {String method, Map params, Function errorCallback}) async {
    try {
      Response response;
      if (method == GET) {
        if (params != null && params.isNotEmpty) {
          var sb = StringBuffer('?');
          params.forEach((key, value) {
            sb.write('$key=$value&');
          });
          var strParams = sb.toString().substring(0, sb.length - 1);
          url += strParams;
        }
        response = await dio.get(url);
      } else if (method == POST) {
        if (params != null && params.isNotEmpty) {
          response = await dio.post(url, data: params);
        } else {
          response = await dio.post(url);
        }
      }

      if (response.statusCode != 200) {
        _handleMessage(errorCallback, 'network error:: errorCode => ${response.statusCode}');
        return null;
      }
      return response;
    } catch (exception) {
      _handleMessage(errorCallback, exception.toString());
      return null;
    }
  }

  void _handleMessage(Function errorCallback, String errorMessage) {
    if (errorCallback != null) errorCallback(errorMessage);
  }
}
