import 'package:meta/meta.dart';

class User{

  User({
    @required this.id,
    @required this.schooId,
    @required this.nickname,
    @required this.phone,
    @required this.dorm,
    @required this.room,
    @required this.headimg
  });

  int id,schooId;
  String nickname,phone,dorm,room,headimg;

  User.fromJson(Map json)
  :id = json['id'],
  schooId = json['schooId'],
  nickname = json['nickname'],
  phone = json['phone'],
  dorm = json['dorm'],
  room = json['room'],
  headimg = json['headimg'];

  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['nickname'] = nickname;
    map['schooId'] = schooId;
    map['phone'] = phone;
    map['dorm'] = dorm;
    map['room'] = room;
    map['headimg'] = headimg;
    return map;
  }
}