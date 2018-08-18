import 'package:meta/meta.dart';

class Order{
  Order({
    this.id,
    this.nickName,
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
    this.lack
  });

  int id,schoolId,deliveryStatus,deliveryMethod;
  double totalFee,payFee;
  String dorm,room,phone,nickName,headimg,takingNum,createDatetime,lack;

  Order.fromJson(Map json)
      : id = json['id'],
        nickName = json['nickName'],
        schoolId = json['schoolId'],
        totalFee = json['totalFee'],
        dorm = json['dorm'],
        room = json['room'],
        phone = json['phone'],
        deliveryStatus = json['deliveryStatus'],
        headimg = json['headimg'],
        payFee = json['payFee'],
        deliveryMethod = json['deliveryMethod'],
        takingNum = json['takingNum'],
        createDatetime = json['createDatetime'],
        lack = json['lack'];

  Map<String,dynamic> toJson(){
    var map = Map<String,dynamic>();
    map['id'] = id;
    map['nickName'] = nickName;
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
    return map;
  }


}