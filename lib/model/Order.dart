import 'package:meta/meta.dart';

class Order{
  Order({
    this.id,
    this.nickname,
    this.schoolId,
    this.totalFee,
    this.payFee,
    this.dorm,
    this.room,
    this.phone,
    this.deliveryStatus,
    this.headimg,
    this.deliveryMethod,
    this.takingNum,
    this.createDatetime,
    this.lack,
    this.packed
  });

  int id,schoolId,deliveryStatus,deliveryMethod,packed;
  double totalFee,payFee;
  String dorm,room,phone,nickname,headimg,takingNum,createDatetime,lack;

  Order.fromJson(Map json)
      : id = json['id'],
        nickname = json['nickname'],
        schoolId = json['schoolId'],
        totalFee = json['totalFee'].toDouble(),
        dorm = json['dorm'],
        room = json['room'],
        phone = json['phone'],
        deliveryStatus = json['deliveryStatus'],
        headimg = json['headimg'],
        payFee = json['payFee'].toDouble(),
        deliveryMethod = json['deliveryMethod'],
        takingNum = json['takingNum'],
        createDatetime = json['createDatetime'],
        lack = json['lack'],
        packed = json['packed'];

  Map<String,dynamic> toJson(){
    var map = Map<String,dynamic>();
    map['id'] = id;
    map['nickname'] = nickname;
    map['schoolId'] = schoolId;
    map['totalFee'] = totalFee;
    map['dorm'] = dorm;
    map['room'] = room;
    map['deliveryStatus'] = deliveryStatus;
    map['headimg'] = headimg;
    map['payFee'] = payFee;
    map['deliveryMethod'] = deliveryMethod;
    map['takingNum'] = takingNum;
    map['createDatetime'] = createDatetime;
    map['lack'] = lack;
    map['packed'] = packed;
    return map;
  }


}