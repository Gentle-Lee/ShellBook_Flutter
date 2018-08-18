class BookSQL{
  static String create = """
  CREATE TABLE IF NOT EXISTS `bk_book` (
  `id` int(11) NOT NULL COMMENT 'id',
  `isbn` varchar(13) NOT NULL COMMENT 'isbn',
  `compressedCover` varchar(80) DEFAULT '/images/book/default.jpg' COMMENT '封面',
  `title` varchar(60) NOT NULL COMMENT '标题',
  `author` varchar(60) NOT NULL COMMENT '作者',
  `press` varchar(40) NOT NULL COMMENT '出版社',
  `edition` varchar(20) NOT NULL COMMENT '版次',
  `originalPrice` double(6,2) NOT NULL COMMENT '原价',
  `sellingPrice` double(6,2) NOT NULL COMMENT '售价',
  PRIMARY KEY (`id`),
  UNIQUE KEY `isbn` (`isbn`)
) ENGINE=InnoDB AUTO_INCREMENT=10079 DEFAULT CHARSET=utf8mb4;""";
}