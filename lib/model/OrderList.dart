import './Order.dart';
class OrderList{
  List<Order> list;
  factory OrderList.fromJson(List<dynamic> parsedJson){
    List<Order> list = new List<Order>();
    list = parsedJson.map((i)=>Order.fromJson(i)).toList();
    return new OrderList(
      list:list
    );
  }
  OrderList({this.list});
}