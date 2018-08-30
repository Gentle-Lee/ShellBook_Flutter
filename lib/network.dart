import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'database/CustomDatabase.dart';
import 'model/Order.dart';
import 'model/OrderToBook.dart';
class NetWork{
  static const String BASE_URL = "https://www.beikebook.com";
  static const String ALL_ORDER = BASE_URL + "/all-order";
  static const String SEARCH_ORDER = BASE_URL + "/search-order?keyword=";
  static const String COMFIRM_ORDER = BASE_URL + '/confirmOrder';
  static const String LOGIN = BASE_URL + '/login';
  static const String USER_URL_PREFIX = 'http://m.beikebook.com';
  static const String IMAGE_URL_PREFIX = 'http://beikebook.com';
  static const String SYNC_FINISHED_ORDER = BASE_URL + '/syncFinishedOrder';
  static const String UPDATE_BOOK_DATABASE = BASE_URL + '/updateBookDataBase';
  static final CustomDatabase database = new CustomDatabase();
  static Dio _dio;
  static Options options = new Options(
    baseUrl:BASE_URL,
    contentType:  ContentType.parse("application/x-www-form-urlencoded"),
  );
  static Dio get instance {
    if(_dio!=null){
      return _dio;
    }
    _dio = new Dio(options);
    return _dio;
  }

  static Future<Response> getRes(url,{params})async {
    print(url);
    return await _dio.get(url,data:params);
  }

  Future<Response> post(url,{param}) async{
    return await _dio.post(url,data: param);
  }

  static Future<bool> syncDatabase()async{
    await NetWork.instance.get(NetWork.ALL_ORDER)
        .then((res)async {
      List jsonA = const JsonCodec().decode(res.data.toString());
      print(jsonA);
      for(int i = 0 ; i < jsonA.length;i++){
        Order order =Order.fromJson(jsonA[i]['order']);
        await database.addOrder(order);
        List books = jsonA[i]['map'];
        for(int j = 0; j < books.length; j ++){
          OrderToBook orderToBook = OrderToBook.fromJson(books[j]);
          await database.addOrderToBook(orderToBook);
        }
      }
      return true;
    });
    return false;
  }


}