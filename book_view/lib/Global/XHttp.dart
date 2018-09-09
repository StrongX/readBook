import 'package:dio/dio.dart';
import 'dart:io';
class XHttp{
  static const domain = 'http://commonapi.cn';

  static get(String url,Map params,void callBak(Map response),void error(DioError e)) async {
    Dio dio = new Dio();
    dio.options.baseUrl = domain;
    if(params == null){
      params = {};
    }
    params['v'] = 1.0;
    dio.options.responseType = ResponseType.JSON;
    try{
      Response response=await dio.get(url,data: params);
      callBak(response.data);
    }on DioError catch(e){
      error(e);
    }
  }
  static getWithCompleteUrl(String url,Map<String, String> params,void callBak(String response)) async {
    print(url);
    Dio dio = new Dio();
    dio.onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
    try{
      Response<String> response=await dio.get(url,data: params);
      callBak(response.data.toString());
    }on DioError catch(e){
      print(e);
    }

  }
}