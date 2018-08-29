import './Order.dart';
import './OrderToBook.dart';
class SearchOrder{
  Order order;
  List<OrderToBook> mapList;
  factory SearchOrder.fromJson(Map parsedJson){
    Order mOrder = Order.fromJson(parsedJson['order']);
    List<OrderToBook> mMap = new List();
    for(int i = 0 ; i < parsedJson['map'].length; i ++){
      mMap.add(OrderToBook.fromJson(parsedJson['map'][i]));
    }
    return new SearchOrder(
        order:mOrder,
        mapList: mMap
    );
  }
  SearchOrder({this.order,this.mapList});
}