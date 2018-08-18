class OrderSQL{
  static String create = """
  CREATE TABLE IF NOT EXISTS `bk_order` (
  `id` int(11) NOT NULL COMMENT 'id',
  `nickname` varchar(60) DEFAULT '',
  `headimg` varchar(200) DEFAULT '/images/user/default.png',
  `schoolId` int(11) NOT NULL COMMENT '学校id',
  `payFee` double(10,2) DEFAULT '0.00' COMMENT '支付金额',
  `totalFee` double(10,2) DEFAULT '0.00' COMMENT '总金额',
  `deliveryMethod` int(1) DEFAULT '0' COMMENT '配送方式id 0自取 1配送',
  `dorm` varchar(40) DEFAULT '' COMMENT '收货宿舍',
  `room` varchar(30) DEFAULT '' COMMENT '收货房间号',
  `phone` varchar(20) DEFAULT '' COMMENT '收货手机号码',
  `takingNum` varchar(30) NOT NULL COMMENT '取书号',
  `createDatetime` datetime NOT NULL COMMENT '下单时间',
  `deliveryStatus` int(1) DEFAULT '0' COMMENT '是否配送 0未配送 2已配送/ 0 未领取 2已领取',
  `lack` text COMMENT '未处理原因',
  PRIMARY KEY (`id`),
  ) ENGINE=InnoDB AUTO_INCREMENT=2855 DEFAULT CHARSET=utf8mb4;
  """;
}