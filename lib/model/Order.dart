import 'package:meta/meta.dart';

class Order{
  Order({
    this.id,
    this.userName,
    this.schoolId,
    this.totalfee,
    this.dorm,
    this.room,
    this.phone,
    this.deliveryStatus
  });

  int id,schoolId,deliveryStatus;
  double totalfee;
  String dorm,room,phone,userName;

  Order.fromJson(Map json)
      : id = json['id'],
        userName = json['userName'],
        schoolId = json['schoolId'],
        totalfee = json['totalfee'],
        dorm = json['dorm'],
        room = json['room'],
        phone = json['phone'],
        deliveryStatus = json['deliveryStatus'];

  Map<String,dynamic> toJson(){
    var map = Map<String,dynamic>();
    map['id'] = id;
    map['userName'] = userName;
    map['schoolId'] = schoolId;
    map['totalfee'] = totalfee;
    map['dorm'] = dorm;
    map['room'] = room;
    map['deliveryStatus'] = deliveryStatus;
    return map;
  }


}