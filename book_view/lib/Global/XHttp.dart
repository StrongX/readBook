import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';

class XHttp{
  static const domain = '127.0.0.1:8000';

  static get(String url,Map<String, String> params,void callBak(String response)) async {

    var httpClient = new HttpClient();
    var uri = new Uri.http(
        domain, url, params);
    var request = await httpClient.postUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    callBak(responseBody);
  }
  static getWithDomain(String doMain,String url,Map<String, String> params,void callBak(String response)) async {
    var httpClient = new HttpClient();
    var uri = new Uri.https(
        doMain, url, params);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    callBak(responseBody);
  }
  static getWithCompleteUrl(String url,Map<String, String> params,void callBak(String response)) async {
    Dio dio = new Dio();
    Response<String> response=await dio.get(url,data: params);
    callBak(response.data.toString());
  }
}