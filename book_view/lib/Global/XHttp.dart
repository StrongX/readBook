import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';

class XHttp{
  static const domain = 'http://127.0.0.1:8000';

  static get(String url,Map<String, String> params,void callBak(Map response),void error(DioError e)) async {
    Dio dio = new Dio();
    dio.options.baseUrl = domain;
    dio.options.responseType = ResponseType.JSON;
    try{
      Response response=await dio.post(url,data: params);
      callBak(response.data);
    }on DioError catch(e){
      error(e);
    }


  }
  static getWithDomain(String doMain,String url,Map<String, String> params,void callBack(String response)) async {
    var httpClient = new HttpClient();
    var uri = new Uri.https(
        doMain, url, params);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    callBack(responseBody);
  }
  static getWithCompleteUrl(String url,Map<String, String> params,void callBak(String response)) async {
    Dio dio = new Dio();
    Response<String> response=await dio.get(url,data: params);
    callBak(response.data.toString());
  }
}