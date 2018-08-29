import './SearchOrder.dart';
class SearchOrderList{
  List<SearchOrder> list;
  factory SearchOrderList.fromJson(List<dynamic> parsedJson){
    List<SearchOrder> list = new List<SearchOrder>();
    list = parsedJson.map((i)=>SearchOrder.fromJson(i)).toList();
    return new SearchOrderList(
        list:list
    );
  }
  SearchOrderList({this.list});
}