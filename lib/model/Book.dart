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
    this.sellingPrice,
    this.compressedCover,
    this.indexCover,
    this.keyword,
    this.createDatetime,
    this.indexDesc,
    this.updateDatetime
  });

  int id;
  String isbn,cover,title,author,press,edition,compressedCover,indexCover,indexDesc,createDatetime,keyword,updateDatetime;
  double originalPrice,sellingPrice;

  Book.fromJson(Map json)
      :id = json['id'],
        isbn = json['isbn'],
        cover = json['cover'],
        title = json['title'],
        author = json['author'] == null ? '无' : json['author'],
        press = json['press'] == null ? '无' : json['press'],
        edition = json['edition'] == null ? '无' : json['edition'],
        originalPrice = json['originalPrice'].toDouble(),
        sellingPrice = json['sellingPrice'].toDouble(),
        compressedCover = json['compressedCover'],
        indexCover = json['indexCover'],
        keyword = json['keyword'],
        createDatetime = json['createDatetime'],
        indexDesc = json['indexDesc'],
        updateDatetime = json['updateDatetime'];

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
    map['compressedCover'] = compressedCover;
    map['indexCover'] = indexCover;
    map['keyword'] = keyword;
    map['createDatetime'] = createDatetime;
    map['indexDesc'] = indexDesc;
    map['updateDatetime'] = updateDatetime;
    return map;
  }
}