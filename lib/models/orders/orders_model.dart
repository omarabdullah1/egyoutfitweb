import 'package:flutter/material.dart';

class OrdersModel {
  String address;
  String orderName;
  String email;
  String firstName;
  String orderedProduct;
  String phoneNumber;
  String otherPhoneNumber;
  String orderComment;
  String orderImage;
  String uid;
  String pState;
  String orderSize;
  num orderedProductsCount;
  num orderCost;
  List orderPromo;
  List orderPromoDiscount;


  OrdersModel({
    @required this.email,
    @required this.firstName,
    @required this.orderComment,
    @required this.orderCost,
    @required this.orderImage,
    @required this.orderPromo,
    @required this.orderPromoDiscount,
    @required this.uid,
    @required this.address,
    @required this.orderSize,
    @required this.orderedProduct,
    @required this.phoneNumber,
    @required this.otherPhoneNumber,
    @required this.pState,
    @required this.orderName,
  });
  OrdersModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    orderComment = json['orderComment'];
    orderCost = json['orderCost'];
    orderImage = json['orderImage'];
    orderPromo = json['orderPromo'];
    orderPromoDiscount = json['orderPromoDiscount'];
    uid = json['uid'];
    orderSize = json['size'];
    address = json['address'];
    orderedProduct = json['orderedProducts'];
    phoneNumber = json['phoneNumber'];
    otherPhoneNumber = json['otherPhoneNumber'];
    orderedProductsCount = json['orderedProductsCount'];
    pState = json['pState'];
    orderName = json['orderName'];
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uid': uid,
      'address': address,
      'orderedProducts': orderedProduct,
      'phoneNumber': phoneNumber,
      'orderedProductsCount': orderedProductsCount,
      'pState': pState,
      'orderImage': orderImage,
      'v': orderName,
    };
  }
}
