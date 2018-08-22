import '../model/Book.dart';
class OrderToBook{
  int id,orderId,bookId,amount;
  OrderToBook({
    this.id,
    this.orderId,
    this.bookId,
    this.amount
  });

  OrderToBook.fromJson(Map json)
      :id = json['id'],
        orderId = json['orderId'],
        bookId = json['bookId'],
        amount = json['amount'];

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['orderId'] = orderId;
    map['bookId'] = bookId;
    map['amount'] = amount;
    return map;
  }
}