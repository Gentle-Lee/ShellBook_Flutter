class OrderSQL{
  static String create = """
  CREATE TABLE IF NOT EXISTS bk_order (
    id INTEGER PRIMARY KEY,
    nickname TEXT DEFAULT '',
    headimg TEXT DEFAULT '/images/user/default.png',
    schoolId INTEGER NOT NULL,
    payFee REAL DEFAULT '0.00',
    totalFee REAL DEFAULT '0.00',
    deliveryMethod INTEGER DEFAULT '0',
    dorm TEXT DEFAULT '',
    room TEXT DEFAULT '',
    phone TEXT DEFAULT '',
    takingNum TEXT NOT NULL,
    createDatetime TEXT NOT NULL ,
    deliveryStatus INTEGER DEFAULT '0',
    lack TEXT
  )
  """;
}