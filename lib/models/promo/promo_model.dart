class PromoModel {
  String promo;
  bool global;
  String product;
  String state;
  num discount;
  String uid;


  PromoModel({
this.discount,
this.promo,
this.state,
this.global,
this.product,
this.uid,
  });
PromoModel.fromJson(Map<String, dynamic> json) {
discount = json['discount'];
promo = json['promo'];
state = json['state'];
global = json['global'];
product = json['product'];
uid = json['uid'];
  }
  Map<String, dynamic> toMap() {
    return {
      'discount': discount,
      'promo': promo,
      'state': state,
      'global': global,
      'product': product,
      'uid': uid,
    };
  }
}
