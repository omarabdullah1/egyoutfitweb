// import 'package:flutter/material.dart';
//
// class ShopLoginModel {
//   String firstName;
//   String secondName;
//   String email;
//   String image;
//   String address;
//   String phone;
//   String organization;
//   String uId;
//   bool isEmailVerfied;
//   bool isSeller;
//   List cart;
//   List favorites;
//   bool sat;
//   bool sun;
//   bool mon;
//   bool tus;
//   bool wed;
//   bool thu;
//   bool fri;
//
//   ShopLoginModel({
//     @required this.firstName,
//     @required this.secondName,
//     @required this.email,
//     @required this.address,
//     @required this.phone,
//     @required this.uId,
//     @required this.isEmailVerfied,
//     @required this.isSeller,
//     @required this.cart,
//     @required this.favorites,
//     @required this.image,
//     @required this.organization,
//     @required this.sat,
//     @required this.sun,
//     @required this.mon,
//     @required this.tus,
//     @required this.wed,
//     @required this.thu,
//     @required this.fri,
//   });
//
//   ShopLoginModel.fromJson(Map<String, dynamic> json) {
//     email = json['email'];
//     phone = json['phone'];
//     address = json['address'];
//     firstName = json['firstName'];
//     secondName = json['secondName'];
//     uId = json['uId'];
//     isEmailVerfied = json['isEmailVerfied'];
//     isSeller = json['isSeller'];
//     cart = json['cart'];
//     favorites = json['favorites'];
//     image = json['image'];
//     organization = json['organization'];
//     sat = json['sat'];
//     sun = json['sun'];
//     mon = json['mon'];
//     thu = json['tus'];
//     wed = json['wed'];
//     thu = json['thu'];
//     fri = json['fri'];
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'firstName': firstName,
//       'secondName': secondName,
//       'phone': phone,
//       'address': address,
//       'email': email,
//       'uId': uId,
//       'isEmailVerfied': isEmailVerfied,
//       'isSeller': isSeller,
//       'cart': cart,
//       'favorites': favorites,
//       'organization': organization,
//       'image': image,
//       'sat': sat,
//       'sun': sun,
//       'mon': mon,
//       'tus': tus,
//       'wed': wed,
//       'thu': thu,
//       'fri': fri,
//     };
//   }
// }
