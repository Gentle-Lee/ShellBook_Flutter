import '../model/Book.dart';
class OrderBook{
  Book book;
  int amount;
  OrderBook({
    this.book,
    this.amount
  });

  factory OrderBook.fromJson(Map<String, dynamic> json){
    Book mBook = Book.fromJson(json);
    int mNum = json['amount'];
    return OrderBook(
        book:mBook,
        amount:mNum
    );
  }

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['book'] = book;
    map['amount'] = amount;
    return map;
  }
}