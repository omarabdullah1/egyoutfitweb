import 'package:flutter/material.dart';

class AdminModel {
  String firstName;
  String email;
  String phone;
  String uid;


  AdminModel({
    @required this.firstName,
    @required this.email,
    @required this.phone,
    @required this.uid,
  });
  AdminModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    firstName = json['firstName'];
    uid = json['uid'];
  }
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'phone': phone,
      'email': email,
      'uid': uid,

    };
  }
}
