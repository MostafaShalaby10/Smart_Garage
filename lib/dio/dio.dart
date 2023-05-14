import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/constants.dart';

class dio {
  static Dio? diio;

  static init() {
    diio = Dio(BaseOptions(
      baseUrl: constants.base,
      headers: {
        'Content-Type': 'application/json',
      },
      receiveDataWhenStatusError: true,
    ));
  }

  // static Future<Response> getdata(
  //     {required String url, required dynamic query}) async {
  //   return await dio!.get(url, queryParameters: query);
  // }

  static Future<Response> postdata({
    required String url,
    required Map<String, dynamic>? data,
    Map<String, dynamic>? query
  }) async {
    print("in function") ;

    return await diio!.post(
      url,
      data: data,
      queryParameters: query,
    );
  }
  static Future<Response?> getData(
      {required String url, Map<String, dynamic>? query}) async {
    return await diio?.get(url, queryParameters: query);
  }
}
