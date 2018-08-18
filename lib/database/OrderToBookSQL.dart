class OrderToBookSQL{
  static String create = """
  CREATE TABLE `bk_orderToBook` (
  `id` int(11) NOT NULL COMMENT 'id',
  `orderId` int(11) DEFAULT '0' COMMENT '订单id',
  `bookId` int(11) DEFAULT '0' COMMENT '书id',
  `amount` int(11) NOT NULL COMMENT '书数量',
  PRIMARY KEY (`id`),
  UNIQUE KEY `orderId` (`orderId`,`bookId`)
  ) ENGINE=InnoDB AUTO_INCREMENT=3738 DEFAULT CHARSET=utf8mb4;
  """;
}