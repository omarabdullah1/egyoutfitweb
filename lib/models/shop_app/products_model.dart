import 'package:flutter/material.dart';

class ShopProductsModel
{
  String name;
  String secondName;
  String description;
  String state;
  List image;
  int oldPrice;
  double discount;
  int price;
  String category;
  String uid;
  List cart;
  List favorites;
  String pbid;
  bool isS;
  bool isM;
  bool isL;
  bool isXL;
  bool is2XL;
  bool is3XL;
  bool is4XL;
  bool is5XL;
  bool isShipping;
  String shippingPrice;
  ShopProductsModel({
    @required this.name,
    @required this.image,
    @required this.category,
    @required this.description,
    @required this.discount,
    @required this.oldPrice,
    @required this.price,
    @required this.uid,
    @required this.cart,
    @required this.favorites,
    @required this.pbid,
    @required this.state,
    @required this.isS,
    @required this.isM,
    @required this.isL,
    @required this.isXL,
    @required this.is2XL,
    @required this.is3XL,
    @required this.is4XL,
    @required this.is5XL,
    @required this.isShipping,
    @required this.shippingPrice,

    // @required this.cart,
  });
  ShopProductsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    category = json['category'];
    description = json['description'];
    discount = json['discount'];
    oldPrice = json['oldPrice'];
    price = json['price'];
    uid = json['uid'];
    cart = json['cart'];
    favorites = json['favorites'];
    pbid = json['pbid'];
    state = json['state'];
    isS = json['isS'];
    isM = json['isM'];
    isL = json['isL'];
    isXL = json['isXL'];
    is2XL = json['is2XL'];
    is3XL = json['is3XL'];
    is4XL = json['is4XL'];
    is5XL = json['is5XL'];
    isShipping = json['isShipping'];
    shippingPrice = json['shippingPrice'];

    // cart = json['cart'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'category': category,
      'description': description,
      'discount': discount,
      'oldPrice': oldPrice,
      'price': price,
      'uid': uid,
      'cart': cart,
      'favorites': favorites,
      'pbid': pbid,
      'state': state,
      'isS': isS,
      'isM': isM,
      'isL': isL,
      'isXL': isXL,
      'is2XL': is2XL,
      'is3XL': is3XL,
      'is4XL': is4XL,
      'is5XL': is5XL,
      'isShipping': isShipping,
      'shippingPrice': shippingPrice,
      // 'cart': cart,
    };
  }
}
