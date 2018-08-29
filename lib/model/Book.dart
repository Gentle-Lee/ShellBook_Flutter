class Book{
  Book({
    this.id,
    this.isbn,
    this.cover,
    this.title,
    this.author,
    this.press,
    this.edition,
    this.originalPrice,
    this.sellingPrice
  });

  int id;
  String isbn,cover,title,author,press,edition;
  double originalPrice,sellingPrice;

  Book.fromJson(Map json)
      :id = json['id'],
        isbn = json['isbn'],
        cover = json['cover'],
        title = json['title'],
        author = json['author'],
        press = json['press'],
        edition = json['edition'],
        originalPrice = json['originalPrice'].toDouble(),
        sellingPrice = json['sellingPrice'].toDouble();

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['isbn'] = isbn;
    map['cover'] = cover;
    map['title'] = title;
    map['author'] = author;
    map['press'] = press;
    map['edition'] = edition;
    map['originalPrice'] = originalPrice;
    map['sellingPrice'] = sellingPrice;
    return map;
  }
}