import 'dart:async';

import 'package:dio/dio.dart';
import 'dart:convert';

class NetWork{
  static final String BASE_URL = "https://www.beikebook.com";
  static final String ALL_ORDER = BASE_URL + "/all-order";
  static final String SEARCH_ORDER = BASE_URL + "/search-order";
  static final String COMFIRM_ORDER = BASE_URL + '/confirmOrder';
  static final String LOGIN = BASE_URL + '/login';
  static final String USER_URL_PREFIX = 'http://m.beikebook.com';
  static final String IMAGE_URL_PREFIX = 'http://beikebook.com';
  static Dio _dio;
  static Options options = new Options(
    baseUrl:BASE_URL,
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

  Future<Response> post(url,{param}) async{
    return await _dio.post(url,data: param);
  }
}