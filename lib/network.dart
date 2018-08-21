import 'dart:async';

import 'package:dio/dio.dart';
import 'dart:convert';

class NetWork{
  static Dio _dio;
  static Options options = new Options(
    baseUrl:"",
    connectTimeout:5000,
    receiveTimeout:3000
  );
  static Dio get instance {
    if(_dio!=null){
      return _dio;
    }
    _dio = new Dio(options);
    return _dio;
  }

  Future<Response> get(url,{params})async {
    return await _dio.get(url,data:params);
  }
}