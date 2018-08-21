class OrderToBookSQL{
  static String create = """
  CREATE TABLE bk_orderToBook(
    id INTEGER NOT NULL PRIMARY KEY,
    orderId INTEGER DEFAULT '0',
    bookId INTEGER DEFAULT '0',
    amount INTEGER NOT NULL
  )
  """;
}