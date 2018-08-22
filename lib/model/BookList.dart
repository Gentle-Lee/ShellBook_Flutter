import '../model/OrderBook.dart';
class BookList{
  List<OrderBook> list;
  factory BookList.fromJson(List<dynamic> parsedJson){
    List<OrderBook> list = new List<OrderBook>();
    list = parsedJson.map((i)=>OrderBook.fromJson(i)).toList();
    return new BookList(
        list:list
    );
  }
  BookList({this.list});
}