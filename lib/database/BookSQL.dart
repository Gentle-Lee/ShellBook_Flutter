class BookSQL{
  static String create = """
  CREATE TABLE IF NOT EXISTS bk_book (
  id INTEGER NOT NULL PRIMARY KEY,
  isbn TEXT NOT NULL ,
  compressedCover TEXT DEFAULT '/images/book/default.jpg' ,
  title TEXT NOT NULL ,
  author TEXT NOT NULL ,
  press TEXT NOT NULL ,
  edition TEXT NOT NULL ,
  originalPrice REAL NOT NULL ,
  sellingPrice REAL NOT NULL 
)""";
}