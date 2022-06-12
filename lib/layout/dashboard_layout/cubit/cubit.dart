import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:egyoutfitweb/layout/dashboard_layout/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import '../../../models/message/message_model.dart';
import '../../../models/orders/orders_model.dart';
import '../../../models/promo/promo_model.dart';
import '../../../models/shop_app/products_model.dart';
import '../../../models/user/user_model.dart';
import '../../../modules/login/login_screen.dart';
import '../../../modules/service_provider/dashboard_screen/dashboard_screen.dart';
import '../../../modules/service_provider/profile_screen/seller_setting_screen.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';

class DashboardCubit extends Cubit<DashboardStates> {
  DashboardCubit() : super(DashboardInitialState());

  static DashboardCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<XFile> listImage = [];
  var image;

  List<String> firebaseLink;
  List firebaseLinkEdit;
  String firebaseImagesEdit;
  List<ShopProductsModel> products = [];

  List<UserModel> users = [];
  List productsID = [];
  List allProductsID = [];
  List offersProductsID = [];
  List<OrdersModel> orderedProducts = [];

  List<OrdersModel> requestOrderModel = [];

  List productsSearched = [];
  List productsSearchedID = [];

  List<OrdersModel> pendingOrderedProductsList = [];
  List<OrdersModel> completedOrderedProductsList = [];
  List<OrdersModel> scheduledOrderedProductsList = [];
  List<OrdersModel> canceledOrderedProductsList = [];

  List<ShopProductsModel> myOrderedProducts = [];
  List<ShopProductsModel> requestModel = [];
  List<ShopProductsModel> pendingOrderedProducts = [];
  List<ShopProductsModel> completedOrderedProducts = [];
  List<ShopProductsModel> scheduledOrderedProducts = [];
  List<ShopProductsModel> canceledOrderedProducts = [];

  // List<ShopProductsModel> model = [];
  List orderedProductsIDList = [];

  List allOrderedProductsID = [];
  List pendingOrderedProductsID = [];
  List scheduledOrderedProductsID = [];
  List completedOrderedProductsID = [];
  List canceledOrderedProductsID = [];
  List requestedOrderedProductsID = [];

  List pendingOrderedProductsIDList = [];
  List completedOrderedProductsIDList = [];
  List scheduledOrderedProductsIDList = [];
  List canceledOrderedProductsIDList = [];

  List offers = [];

  List orderedProductsStateList = [];

  List pendingOrderedProductsStateList = [];
  List completedOrderedProductsStateList = [];
  List scheduledOrderedProductsStateList = [];
  List canceledOrderedProductsStateList = [];
  List requestModelStateList = [];

  List orderedProductsCountList = [];

  List pendingOrderedProductsCountList = [];
  List completedOrderedProductsCountList = [];
  List scheduledOrderedProductsCountList = [];
  List canceledOrderedProductsCountList = [];
  List requestModelCountList = [];

  List<PromoModel> promoModel = [];

  List allPromoCodesIDList = [];

  List promoCodesList = [];

  List promoCodesStateList = [];

  List myPromoCodesStateList = [];

  List myPromoCodesList = [];

  List promoCodesIDList = [];

  List myPromoCodesIDList = [];

  List discountList = [];

  List myDiscountList = [];

  var itemsEn = [
    'All Requests',
    'Pending',
    'Scheduled',
    'Completed',
    'Cancelled',
  ];
  var itemsAr = [
    'كل الطلبات',
    'قيد الانتظار',
    'مجدول',
    'مكتمل',
    'ملغي',
  ];
  var createProductItemsEn = [
    'None',
    'Men',
    'Women',
    'Shoe',
    'Children',
    'Bags',
    'Sports',
    'Accessories'
  ];
  var requestProductItemsEn = [
    'Pending',
    'Scheduled',
    'Completed',
    'Cancelled',
  ];
  var requestProductItemsAr = [
    'قيد الانتظار',
    'مجدول',
    'مكتمل',
    'ملغي',
  ];
  var productProductItemsEn = [
    'Approved',
    'Pending',
    'Cancelled',
  ];
  var productProductItemsAr = [
    'قيد الانتظار',
    'مقبول',
    'ملغي',
  ];

  String userRegisterDropdownValueEn;
  String userRegisterDropdownValueAr;
  List cityItemsEn = <String>[
    'Cairo',
    'Alexandria',
    'Giza',
    'Matrouh',
    'Port Said',
    'Helwan',
    'Port Said',
    'Al-Mahallah Al-Kubra',
    'Tanta',
    'Suez',
    'Asyut',
    'Al-Fayoum',
    'Ismailia',
    'Damietta',
    'Al-Minya',
    'Luxor',
    'Qema',
    'Sohag',
    'Bani Sewief',
    'Al-Sharkya',
    'Al-Gharbya',
    'Sinai',
    'Al-Wady El-Geded',
    'Al-Monofya',
    'Qalubia',
    'Dakahlya',
    'Red Sea',
    'Beheira',
  ];
  List cityItemsAr = <String>[
    "القاهرة",
    'الإسكندرية',
    'الجيزة',
    'مطروح',
    'بورسعيد',
    'حلوان',
    'بورسعيد'
        'المحلة الكبرى',
    "طنطا",
    "السويس",
    "أسيوط",
    "الفيوم",
    'الإسماعيلية',
    'دمياط',
    'المنيا',
    "الأقصر",
    'قمة',
    'سوهاج',
    "بني سويف",
    'الشرقية',
    'الغربية',
    'سيناء',
    'الوادي الجديد',
    'المنوفية',
    'القليوبية',
    'الدقهلية',
    'البحر الاحمر',
    "البحيرة",
  ];

  bool isS = false;
  bool isM = false;
  bool isL = false;
  bool isXL = false;
  bool is2XL = false;
  bool is3XL = false;
  bool is4XL = false;
  bool is5XL = false;

  bool isSaturday = false;
  bool isSunday = false;
  bool isMonday = false;
  bool isTuesday = false;
  bool isWednesday = false;
  bool isThursday = false;
  bool isFriday = false;

  bool promoToggle = false;
  bool discountToggle = false;
  bool deliveryToggle = false;
  bool promoDiscountToggle = false;
  bool stateChanged = false;
  bool pstateChanged = false;
  bool isUpdate = false;
  bool isDialOpen = false;
  bool isEnglish = CacheHelper.getData(key: 'lang') == 'en' ? true : false;

  List<Widget> bottomScreens = [
    const DashboardScreen(),
    const RequestsScreen(),
    const SellerSettingScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(DashboardChangeBottomNavState());
  }

  var dropDownValueEn = 'All Requests';
  var dropDownValueAr = 'كل الطلبات';
  var productdropDownValueEn = 'Pending';
  var productdropDownValueAr = 'قيد الانتظار';
  var lastDropDownValueEn = 'All Requests';
  var lastDropDownValueAr = 'كل الطلبات';
  var lastproductDropDownValueEn = 'Pending';
  var lastproductDropDownValueAr = 'قيد الانتظار';
  var requestDropDownValueEn = 'Pending';
  var requestDropDownValueAr = 'قيد الانتظار';

  var productDropDownValueEn = 'Pending';
  var productDropDownValueAr = 'قيد الانتظار';

  var createScreenDropDownValueEn = 'None';
  var createScreenDropDownValueAr = 'لا شيء';
  Color dropDownValueColor = Colors.white;
  Color productdropDownValueColor = Colors.white;
  Color requesdtDropDownValueColor = Colors.white;

  Color productDropDownValueColor = Colors.white;

  UserModel loginModel;

  userLogin({
    @required context,
    @required String email,
    @required String password,
  }) {
    emit(DashboardLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      FirebaseFirestore.instance
          .collection('users')
          .doc(value.user.uid)
          .get()
          .then((value) async {
        loginModel = UserModel.fromJson(value.data());
        isSaturday = loginModel.sat;
        isSunday = loginModel.sun;
        isMonday = loginModel.mon;
        isTuesday = value.data()['tus'];
        isWednesday = loginModel.wed;
        isThursday = loginModel.thu;
        isFriday = loginModel.fri;

        emit(DashboardLoginSuccessState(loginModel));
      }).catchError((error) {
        log(error.toString());
        emit(DashboardLoginErrorState((error.toString())));
      });
    }).catchError((error) {
      emit(DashboardLoginErrorState(error.toString()));
    });
  }

  updateSellerData({
    uid,
    fname,
    sname,
    phone,
    address,
    organization,
    city,
    sat,
    sun,
    mon,
    tus,
    wed,
    thu,
    fri,
    image,
    context,
  }) async {
    emit(UpdateStateLoadingDashboardState());
    if (image != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'address': address,
        'firstName': fname,
        'secondName': sname,
        'phone': phone,
        'organization': organization,
        'city': EasyLocalization.of(context).locale.languageCode == 'en'
            ? city
            : cityItemsEn[cityItemsAr.indexOf(city)],
        'image': image,
        'sat': sat,
        'sun': sun,
        'mon': mon,
        'tus': tus,
        'wed': wed,
        'thu': thu,
        'fri': fri,
      }).then((value) async {
        await userLogin(
            context: context,
            email: CacheHelper.getData(key: 'user'),
            password: CacheHelper.getData(key: 'pass'));
        listImage = [];
        image = null;
        firebaseImagesEdit = null;
        await getAllProducts();
        await getAllOrdered(context);
        emit(UpdateStateSuccessDashboardState());
      }).catchError((err) {
        log(err.toString());
        emit(UpdateStateErrorDashboardState());
      });
    } else {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'address': address,
        'firstName': fname,
        'secondName': sname,
        'phone': phone,
        'organization': organization,
        'city': EasyLocalization.of(context).locale.languageCode == 'en'
            ? city
            : cityItemsEn[cityItemsAr.indexOf(city)],
        'sat': sat,
        'sun': sun,
        'mon': mon,
        'tus': tus,
        'wed': wed,
        'thu': thu,
        'fri': fri,
      }).then((value) async {
        await userLogin(
            context: context,
            email: CacheHelper.getData(key: 'user'),
            password: CacheHelper.getData(key: 'pass'));
        image = null;
        firebaseImagesEdit = null;
        await getAllProducts();
        await getAllOrdered(context);
        currentIndex = 0;
        emit(UpdateStateSuccessDashboardState());
        Navigator.pop(context);
      }).catchError((err) {
        log(err.toString());
        emit(UpdateStateErrorDashboardState());
      });
    }
  }

  updateLocation({
    uid,
    latitude,
    longitude,
    posStreet,
  }) {
    emit(UpdateLocationLoadingDashboardState());
    FirebaseFirestore.instance.collection('users').doc(uid).update({
      'posStreet': posStreet,
      'longitude': longitude,
      'latitude': latitude,
    }).then((value) async {
      emit(UpdateLocationSuccessDashboardState());
    }).catchError((err) {
      log(err.toString());
      emit(UpdateLocationErrorDashboardState());
    });
  }

  getOffers() {
    FirebaseFirestore.instance.collection('banners').get().then((value) {
      for (var element in value.docs) {
        offers = element.data().values.first;
        for (var ele in offers) {
          log(ele);
        }
        emit(GetOffersSuccessState());
      }
    }).catchError((error) {
      emit(GetOffersErrorState());
    });
  }

  getAllProducts() {
    productsID.clear();
    products.clear();
    offersProductsID.clear();

    /////////// products//////////////
    FirebaseFirestore.instance.collection('products').get().then((value) {
      for (var element in value.docs) {
        allProductsID.add(element.id);
        if (element.data()['uid'] == CacheHelper.getData(key: 'token')) {
          products.add(ShopProductsModel.fromJson(element.data()));
          productsID.add(element.id);
        }
        // log(element.id);
      }
      emit(GetProductsSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(GetProductsErrorState());
    });
  }

  // getAllUsers() {
  //   users.clear();
  //   /////////// Users//////////////
  //   FirebaseFirestore.instance.collection('users').get().then((value) {
  //     for (var element in value.docs) {
  //       users.add(UserModel.fromJson(element.data()));
  //       log(element.id);
  //     }
  //     emit(GetUsersSuccessState());
  //   }).catchError((error) {
  //     log(error.toString());
  //     emit(GetUsersErrorState());
  //   });
  // }

  changeDropButtonValue(String newValue, context) {
    EasyLocalization.of(context).locale.languageCode == 'en'
        ? dropDownValueEn = newValue
        : dropDownValueAr = newValue;
    if (newValue == 'Completed' || newValue == 'مكتمل') {
      dropDownValueColor = Colors.green;
      requestModel = completedOrderedProducts;
      requestOrderModel = completedOrderedProductsList;
      requestModelCountList = completedOrderedProductsCountList;
      requestModelStateList = completedOrderedProductsStateList;
      requestedOrderedProductsID = completedOrderedProductsID;
      log('completed from');
    } else if (newValue == 'Scheduled' || newValue == 'مجدول') {
      dropDownValueColor = Colors.blue;
      requestModel = scheduledOrderedProducts;
      requestOrderModel = scheduledOrderedProductsList;
      requestModelCountList = scheduledOrderedProductsCountList;
      requestModelStateList = scheduledOrderedProductsStateList;
      requestedOrderedProductsID = scheduledOrderedProductsID;
      log('Scheduled from');
    } else if (newValue == 'Cancelled' || newValue == 'ملغي') {
      dropDownValueColor = Colors.red;
      requestModel = canceledOrderedProducts;
      requestOrderModel = canceledOrderedProductsList;
      requestModelCountList = canceledOrderedProductsCountList;
      requestModelStateList = canceledOrderedProductsStateList;
      requestedOrderedProductsID = canceledOrderedProductsID;
      log('Cancelled from');
    } else if (newValue == 'Pending' || newValue == 'قيد الانتظار') {
      dropDownValueColor = Colors.orange;
      requestModel = pendingOrderedProducts;
      requestOrderModel = pendingOrderedProductsList;
      requestModelCountList = pendingOrderedProductsCountList;
      requestModelStateList = pendingOrderedProductsStateList;
      requestedOrderedProductsID = pendingOrderedProductsID;
      log('Pending from');
    } else if (newValue == 'All Requests' || newValue == 'كل الطلبات') {
      dropDownValueColor = Colors.white;
      requestModel = myOrderedProducts;
      requestOrderModel = orderedProducts;
      requestModelCountList = orderedProductsCountList;
      requestModelStateList = orderedProductsStateList;
      requestedOrderedProductsID = allOrderedProductsID;
      log(requestOrderModel.toString());
      log('All Requests from');
    }
    emit(ChangeDropDashboardState());
  }

  changeRequestDropButtonValue(String newValue, String id, context) {
    requestDropDownValueEn = newValue;
    log(requestDropDownValueAr);
    log(requestDropDownValueEn);
    if (newValue == 'Completed') {
      requesdtDropDownValueColor = Colors.green;
    } else if (newValue == 'Scheduled') {
      requesdtDropDownValueColor = Colors.blue;
    } else if (newValue == 'Cancelled') {
      requesdtDropDownValueColor = Colors.red;
    } else if (newValue == 'Pending') {
      requesdtDropDownValueColor = Colors.orange;
    } else if (newValue == 'All Requests') {
      requesdtDropDownValueColor = Colors.white;
    }
    emit(ChangeDropRequestState());
  }

  changeProductDropButtonValue(String newValue, context) {
    productDropDownValueEn = newValue;
    log(productDropDownValueAr);
    log(productDropDownValueEn);
    if (newValue == 'Pending') {
      productDropDownValueColor = Colors.orange;
    } else if (newValue == 'Approved') {
      productDropDownValueColor = Colors.green;
    } else if (newValue == 'Cancelled') {
      productDropDownValueColor = Colors.red;
    }
    emit(ChangeDropRequestState());
  }

  changeOrderState(value, id, dropVal, context) async {
    emit(UpdateStateLoadingDashboardState());
    await FirebaseFirestore.instance.collection('orders').doc(id).update({
      'pState': value,
    }).then((val) {
      log(value.toString());
      log('updated');
      changeRequestState(
        false,
      );
      changeRequestColor(
        requestDropDownValueEn,
      );
      getAllOrdered(context);
      // dropDownValue=widget.dropValue;
      changeDropButtonValue(dropVal, context);
      lastDropDownValueEn = dropVal;
      emit(UpdateStateSuccessDashboardState());
    }).catchError((error) {
      log('error in updated');
      emit(UpdateStateErrorDashboardState());
    });
  }

  changeOrderProductState(value, id, context) async {
    emit(UpdateStateLoadingDashboardState());
    await FirebaseFirestore.instance.collection('products').doc(id).update({
      'state': value,
    }).then((val) {
      log(value.toString());
      log('updated');
      changeRequestState(
        false,
      );
      changeRequestColor(
        productDropDownValueEn,
      );
      getAllProducts();
      // dropDownValue=widget.dropValue;
      emit(UpdateStateSuccessDashboardState());
    }).catchError((error) {
      log('error in updated');
      emit(UpdateStateErrorDashboardState());
    });
  }

  changeRequestState(bool value) {
    stateChanged = value;
    emit(ChangeStateDashboardState());
  }

  changeProductState(bool value) {
    pstateChanged = value;
    emit(ChangeStateDashboardState());
  }

  changeRequestColor(state) {
    requestDropDownValueEn = state;
    if (state == 'Completed') {
      requesdtDropDownValueColor = Colors.green;
    } else if (state == 'Scheduled') {
      requesdtDropDownValueColor = Colors.blue;
    } else if (state == 'Cancelled') {
      requesdtDropDownValueColor = Colors.red;
    } else if (state == 'Pending') {
      requesdtDropDownValueColor = Colors.orange;
    } else if (state == 'All Requests') {
      requesdtDropDownValueColor = Colors.white;
    }
    emit(ChangeStateDashboardState());
  }

  changeProductColor(state) {
    productDropDownValueEn = state;
    if (state == 'Approved') {
      productDropDownValueColor = Colors.green;
    } else if (state == 'Pending') {
      productDropDownValueColor = Colors.orange;
    } else if (state == 'Cancelled') {
      productDropDownValueColor = Colors.red;
    }
    emit(ChangeStateDashboardState());
  }

  changeCreateProductDropButtonValue(String newValue) {
    createScreenDropDownValueEn = newValue;
    emit(ChangeCreateProductDropDashboardState());
  }

  changeEditProductDropButtonValue(String newValue, context) {
    createScreenDropDownValueEn = newValue;
    emit(ChangeCreateProductDropDashboardState());
  }

  changeEditDropButtonValue() {
    emit(ChangeCreateProductDropDashboardState());
  }

  createProduct({
    @required String category,
    @required String description,
    @required List image,
    @required String name,
    @required double discount,
    @required int oldPrice,
    @required int price,
    @required String pbid,
    @required bool isS,
    @required bool isM,
    @required bool isL,
    @required bool isXL,
    @required bool is2XL,
    @required bool is3XL,
    @required bool is4XL,
    @required bool is5XL,
    @required bool isShipping,
    @required bool isDiscount,
    @required String shippingPrice,
    @required String state,
  }) async {
    emit(CreateProductLoadingState());
    var create = FirebaseFirestore.instance.collection('products').doc();
    create.set({
      'category': category,
      'description': description,
      'image': image,
      'name': name,
      'discount': discount,
      'oldPrice': oldPrice,
      'price': price,
      'pbid': pbid,
      'uid': await CacheHelper.getData(key: 'token'),
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
      'state': 'Pending',
    }).then((value) {
      log(create.id);
      emit(CreateProductSuccessState());
      // firebaseLink=[];
    }).catchError((err) {
      log(err.toString());
      emit(CreateProductErrorState());
    });
  }

  createPromo({
    @required String promo,
    @required int discount,
    @required bool isDiscount,
  }) async {
    emit(CreatePromoLoadingState());
    FirebaseFirestore.instance.collection('promo').doc().set({
      'global': false,
      'discount': discount,
      'uid': await CacheHelper.getData(key: 'token'),
      'state': isDiscount ? 'Active' : 'NotActive',
      'product': '',
      'promo': promo,
    }).then((value) {
      emit(CreatePromoSuccessState());
      // firebaseLink=[];
    }).catchError((err) {
      log(err.toString());
      emit(CreatePromoErrorState());
    });
  }

  updatePromo({
    @required String id,
    @required String promo,
    @required int discount,
    @required bool isDiscount,
  }) async {
    emit(CreatePromoLoadingState());
    FirebaseFirestore.instance.collection('promo').doc(id).update({
      'global': false,
      'discount': discount,
      'uid': await CacheHelper.getData(key: 'token'),
      'state': isDiscount ? 'Active' : 'NotActive',
      'product': '',
      'promo': promo,
    }).then((value) {
      emit(CreatePromoSuccessState());
      // firebaseLink=[];
    }).catchError((err) {
      log(err.toString());
      emit(CreatePromoErrorState());
    });
  }

  updateProduct({
    @required String category,
    @required String description,
    @required String name,
    @required double discount,
    @required int oldPrice,
    @required int price,
    @required String pbid,
    @required bool isS,
    @required bool isM,
    @required bool isL,
    @required bool isXL,
    @required bool is2XL,
    @required bool is3XL,
    @required bool is4XL,
    @required bool is5XL,
    @required bool isShipping,
    @required bool isDiscount,
    @required String shippingPrice,
    @required String state,
    @required String id,
  }) async {
    emit(UpdateProductLoadingState());
    var create = FirebaseFirestore.instance.collection('products').doc(id);
    create.update({
      'category': category,
      'description': description,
      'name': name,
      'discount': discount,
      'oldPrice': oldPrice,
      'price': price,
      'pbid': pbid,
      'uid': await CacheHelper.getData(key: 'token'),
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
      'state': 'Pending',
    }).then((value) {
      log(create.id);
      emit(UpdateProductSuccessState());
    }).catchError((err) {
      log(err.toString());
      emit(UpdateProductErrorState());
    });
  }

  Future<void> updateProductImage({
    @required String id,
    @required List images,
  }) async {
    emit(UpdateProductImageLoadingState());
    var create = FirebaseFirestore.instance.collection('products').doc(id);
    create.update({
      'image': images,
    }).then((value) {
      log(create.id);
      emit(UpdateProductImageSuccessState());
      firebaseLink = [];
    }).catchError((err) {
      log(err.toString());
      emit(UpdateProductImageErrorState());
    });
  }

  // Future<void> getImage(bool isCamera) async {
  //   emit(LoadingPickImageState());
  //   var picker = ImagePicker();
  //   List pickedFile = await picker.pickImage(
  //       source: isCamera ? ImageSource.camera : ImageSource.gallery);
  //   if (pickedFile != null) {
  //     listImage.add(pickedFile);
  //     emit(SuccessPickImageState());
  //   } else {
  //     log('No image selected.');
  //     emit(ErrorPickImageState());
  //   }
  // }

  Future<void> getImageProfile(bool isCamera) async {
    emit(LoadingPickImageState());
    image =null ;
    var picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      image = pickedFile;
      emit(SuccessPickImageState());
    } else {
      log('No image selected.');
      emit(ErrorPickImageState());
    }
  }

  changeUpdateState(value) {
    isUpdate = value;
    emit(ChangeUpdateDashboardState());
  }

  Future<void> getMultiImage(bool isCamera) async {
    emit(LoadingPickImageState());
    var picker = ImagePicker();
    final List<XFile> pickedFileList = await picker.pickMultiImage();
    // final pickedFile = await picker.pickImage(
    //     source: ImageSource.gallery);
    if (pickedFileList != null) {
      // listImage = File(pickedFile.path);
      for (var ele in pickedFileList) {
        listImage.add(ele);
        // log(ele.relativePath.toString());
      }
      emit(SuccessPickImageState());
    } else {
      log('No image selected.');
      emit(ErrorPickImageState());
    }
  }

  removeImageFromList(index) {
    listImage.removeAt(index);
    caroIndex = 0;
    emit(SuccessRemoveImageState());
  }

  Future<void> uploadToFireBase() async {
    emit(LoadingUploadImageState());
    firebaseLink = [];
    for (var element in listImage) {
      await FirebaseStorage.instance
          .ref('gs://egyoutfit-a9d89.appspot.com/products/')
          .child('web'+element.name)
          .putData(
            await element.readAsBytes(),
            SettableMetadata(contentType: 'image/jpeg'),
          )
          .then((val) async {
            await FirebaseStorage.instance
                .ref('gs://egyoutfit-a9d89.appspot.com/products/${'web' + element.name}').getDownloadURL().then((value) {
                  firebaseLink.add(value);
              log(value.toString());
            });
      });
    }
  }

  Future<void> uploadEditToFireBase({pId, pListImage, context}) async {
    emit(LoadingUploadImageState());
    firebaseLinkEdit = [];
    for (var element in listImage) {
      await FirebaseStorage.instance
          .ref('gs://egyoutfit-a9d89.appspot.com/products/')
          .child('web'+element.name)
          .putData(
        await element.readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      )
          .then((value) async {
        await FirebaseStorage.instance
            .ref('gs://egyoutfit-a9d89.appspot.com/products/${'web' + element.name}')
            .getDownloadURL()
            .then((value) {
              firebaseLinkEdit.add(value.toString());
              log(value.toString());
              updateProductImage(
                id: pId,
                images: firebaseLinkEdit + pListImage,
              ).whenComplete(() {
                getAllProducts();
                getAllOrdered(context);
                Navigator.pop(context);
                Navigator.pop(context);
              });
            })
            .whenComplete(
              () => emit(SuccessUploadImageState()),
            )
            .catchError((err) {
              log(err.toString());
              emit(ErrorUploadImageState());
            });
      });
    }
    emit(SuccessUploadAllImageState());
  }

  Future<void> uploadProfileImageToFireBase({
    uid,
    fname,
    sname,
    phone,
    address,
    organization,
    city,
    sat,
    sun,
    mon,
    tus,
    wed,
    thu,
    fri,
    context,
  }) async {
    emit(LoadingUploadImageState());
    firebaseImagesEdit = '';
    await FirebaseStorage.instance
        .ref('gs://egyoutfit-a9d89.appspot.com/products/')
        .child('web'+image.name)
        .putData(
      await image.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    )
        .then((value) async {
      await FirebaseStorage.instance
          .ref('gs://egyoutfit-a9d89.appspot.com/products/${'web' + image.name}')
          .getDownloadURL()
          .then((value) {
            firebaseImagesEdit = value.toString();
            log(value.toString());
            updateSellerData(
              uid: uid,
              fname: fname,
              sname: sname,
              phone: phone,
              organization: organization,
              address: address,
              image: firebaseImagesEdit,
              context: context,
              city: city,
              sat: sat,
              sun: sun,
              mon: mon,
              tus: tus,
              wed: wed,
              thu: thu,
              fri: fri,
            );
          })
          .whenComplete(() => emit(SuccessUploadImageState()))
          .catchError((err) {
            log(err.toString());
            emit(ErrorUploadImageState());
          });
    });
  }

  // Future<List> uploadEditToFireBase() async {
  //   emit(LoadingUploadImageState());
  //   for (var element in listImage) {
  //     firebase_storage.FirebaseStorage.instance
  //         .ref()
  //         .child('products/${Uri.file(element).pathSegments.last}')
  //         .putFile(File(element))
  //         .then((value) {
  //       value.ref
  //           .getDownloadURL()
  //           .then((value) {
  //             firebaseLink.add(value.toString());
  //             log(value.toString());
  //             // emit(SuccessUploadImageState());
  //           })
  //           .whenComplete(() => emit(SuccessUploadImageState()))
  //           .catchError((err) {
  //             log(err.toString());
  //             emit(ErrorUploadImageState());
  //           });
  //     });
  //   }
  //   emit(SuccessUploadAllImageState());
  //   return firebaseLink;
  // }

  timeProgress() {
    emit(LoadingState());
    // log(firebaseLinkEdit.toString());
    //  updateProductImage(
    //     id: id,
    //     images: list);
    //  getAllProducts();
    //  getAllOrdered();
    var tim = Timer(const Duration(seconds: 5), () {
      emit(SuccessState());
    });
    tim.cancel();
    // firebaseLinkEdit = [];
    // Navigator.pop(context);
    //   Navigator.pop(context);
  }

  getAllOrdered(context) {
    orderedProducts.clear();
    orderedProductsIDList.clear();
    allOrderedProductsID.clear();
    pendingOrderedProductsID.clear();
    scheduledOrderedProductsID.clear();
    requestedOrderedProductsID.clear();
    completedOrderedProductsID.clear();
    canceledOrderedProductsID.clear();
    pendingOrderedProductsIDList.clear();
    scheduledOrderedProductsList.clear();
    pendingOrderedProductsCountList.clear();
    pendingOrderedProductsStateList.clear();
    scheduledOrderedProductsStateList.clear();
    scheduledOrderedProductsCountList.clear();
    scheduledOrderedProductsIDList.clear();
    completedOrderedProductsList.clear();
    canceledOrderedProductsIDList.clear();
    completedOrderedProductsIDList.clear();
    orderedProductsCountList.clear();
    myOrderedProducts.clear();
    pendingOrderedProducts.clear();
    pendingOrderedProductsList.clear();
    scheduledOrderedProducts.clear();
    completedOrderedProducts.clear();
    canceledOrderedProducts.clear();
    orderedProductsStateList.clear();
    completedOrderedProductsCountList.clear();
    completedOrderedProductsStateList.clear();
    canceledOrderedProductsList.clear();
    canceledOrderedProductsCountList.clear();
    canceledOrderedProductsStateList.clear();

    dropDownValueEn = 'All Requests';
    dropDownValueColor = Colors.white;
    requestModel.clear();
    requestOrderModel.clear();
    // myOrderedProducts.clear();
    FirebaseFirestore.instance.collection('orders').get().then((value) {
      for (var element in value.docs) {
        if (productsID.contains(element.data()['orderedProducts'])) {
          orderedProducts.add(OrdersModel.fromJson(element.data()));
          orderedProductsStateList.add(element.data()['pState'].toString());
          log(element.id);

          allOrderedProductsID.add(element.id);
          if (element.data()['pState'] == 'Pending') {
            pendingOrderedProductsID.add(element.id);
          } else if (element.data()['pState'] == 'Scheduled') {
            scheduledOrderedProductsID.add(element.id);
          } else if (element.data()['pState'] == 'Completed') {
            completedOrderedProductsID.add(element.id);
          } else if (element.data()['pState'] == 'Cancelled') {
            canceledOrderedProductsID.add(element.id);
          }
        }
      }
      for (var element in orderedProducts) {
        log(element.pState.toString());
        if (productsID.contains(element.orderedProduct)) {
          orderedProductsIDList.add(element.orderedProduct);
          if (element.pState == 'Pending') {
            pendingOrderedProductsList.add(element);
            pendingOrderedProductsIDList.add(element.orderedProduct);
            pendingOrderedProductsCountList.add(element.orderedProductsCount);
            pendingOrderedProductsStateList.add(element.pState);
          } else if (element.pState == 'Scheduled') {
            scheduledOrderedProductsList.add(element);
            scheduledOrderedProductsIDList.add(element.orderedProduct);
            scheduledOrderedProductsCountList.add(element.orderedProductsCount);
            scheduledOrderedProductsStateList.add(element.pState);
          } else if (element.pState == 'Completed') {
            completedOrderedProductsList.add(element);
            completedOrderedProductsIDList.add(element.orderedProduct);
            completedOrderedProductsCountList.add(element.orderedProductsCount);
            completedOrderedProductsStateList.add(element.pState);
          } else if (element.pState == 'Cancelled') {
            canceledOrderedProductsList.add(element);
            canceledOrderedProductsIDList.add(element.orderedProduct);
            canceledOrderedProductsCountList.add(element.orderedProductsCount);
            canceledOrderedProductsStateList.add(element.pState);
          }
        } else {
          log('this product is not mine');
        }
        orderedProductsCountList.add(element.orderedProductsCount);
      }
      for (var element in orderedProductsIDList) {
        myOrderedProducts.add(products[productsID.indexOf(element)]);
      }
      for (var element in pendingOrderedProductsIDList) {
        pendingOrderedProducts.add(products[productsID.indexOf(element)]);
      }
      for (var element in scheduledOrderedProductsIDList) {
        scheduledOrderedProducts.add(products[productsID.indexOf(element)]);
      }
      for (var element in completedOrderedProductsIDList) {
        completedOrderedProducts.add(products[productsID.indexOf(element)]);
      }
      for (var element in canceledOrderedProductsIDList) {
        canceledOrderedProducts.add(products[productsID.indexOf(element)]);
      }
      requestModel = myOrderedProducts;
      requestOrderModel = orderedProducts;
      requestModelCountList = orderedProductsCountList;
      requestModelStateList = orderedProductsStateList;
      requestedOrderedProductsID = allOrderedProductsID;

      log('omar');
      log(productsID.toString());
      // log(orderedProducts.toString());
      log(orderedProductsIDList.toString());
      // myOrderedProducts
      //   ..forEach((element) {
      //     log(element.state.toString());
      //   });
      log(requestModelCountList.toString());
      log(requestModelStateList.toString());
      log(myOrderedProducts.toString());
      // log(productsID.toString());
      // orderedProducts.forEach((element) {log(element.orderedProduct.toString());});
      // for (var e in myOrderedProducts) {
      //   log(e.name);
      //   log(e.state);
      // }
      // for (var e in orderedProductsIDList) {
      //   log(e);
      // }
      // for (var e in orderedProductsCountList) {
      //   log(e.toString());
      // }
      emit(GetProductsSuccessState());
    }).catchError((error) {
      emit(GetProductsErrorState());
    });
  }

  getPromoCodes() async {
    promoModel.clear();
    promoCodesList.clear();
    promoCodesIDList.clear();
    discountList.clear();
    myPromoCodesIDList.clear();
    myPromoCodesList.clear();
    myDiscountList.clear();
    allPromoCodesIDList.clear();
    promoCodesStateList.clear();
    myPromoCodesStateList.clear();
    emit(GetPromoCodesLoadingState());
    await FirebaseFirestore.instance
        .collection('promo')
        .get()
        .then((value) async {
      for (var element in value.docs) {
        // log(element.data()['promo']);
        promoModel.add(PromoModel.fromJson(element.data()));
        allPromoCodesIDList.add(element.id);
      }
      for (var element in promoModel) {
        promoCodesList.add(element.promo);
        promoCodesIDList.add(element.uid);
        discountList.add(element.discount);
        promoCodesStateList.add(element.state);
        log(element.product.toString());
      }
      for (var element in promoCodesList) {
        if (promoCodesIDList[promoCodesList.indexOf(element)] ==
            await CacheHelper.getData(key: 'token')) {
          myPromoCodesList.add(element);
          myDiscountList.add(discountList[promoCodesList.indexOf(element)]);
          myPromoCodesStateList
              .add(promoCodesStateList[promoCodesList.indexOf(element)]);
        }
      }
      for (var ele in promoCodesStateList) {
        log(ele.toString());
        log('');
      }
      for (var ele in myPromoCodesStateList) {
        log(ele.toString());
        // log('');
      }
      // for(var ele in promoCodesIDList){
      //   if(ele == await CacheHelper.getData(key: 'token')){
      //     myPromoCodesIDList.add(ele);
      //     myPromoCodesList.add(promoCodesList[promoCodesIDList.indexOf(ele)]);
      //     myDiscountList.add(discountList[promoCodesIDList.indexOf(ele)]);
      //   }
      // }
      emit(GetPromoCodesSuccessState());
      return promoCodesList;
    }).catchError((err) {
      log(err.toString());
      emit(GetPromoCodesErrorState());
      return [];
    });
  }

  deletePromo(id) async {
    if (allPromoCodesIDList.contains(id)) {
      log('message');
      await FirebaseFirestore.instance.collection('promo').doc(id).delete();
      // await getPromoCodes();
    }
  }

  void search(String text) {
    productsSearched.clear();
    emit(SearchLoadingState());
    for (var element in products) {
      if (element.name.contains(text) ||
          element.description.contains(text) ||
          element.pbid.contains(text)) {
        productsSearched.add(element);
        productsSearchedID.add(productsID[products.indexOf(element)]);
      }
      // productsSearched.add(element);
    }
    // for(var element in productsSearched){
    //   log(element.name);
    // }
    // for(var element in products){
    //   log(element.name);
    // }
    // for(var element in productsSearched){
    //   log(element.name);
    // }
    // log(products);
    emit(SearchSuccessState());
  }

  saveState(drop) {
    if (drop == 'Completed') {
      dropDownValueColor = Colors.green;
      requestModel = completedOrderedProducts;
      requestOrderModel = completedOrderedProductsList;
      requestModelCountList = completedOrderedProductsCountList;
      requestModelStateList = completedOrderedProductsStateList;
      requestedOrderedProductsID = completedOrderedProductsID;
    } else if (drop == 'Scheduled') {
      dropDownValueColor = Colors.blue;
      requestModel = scheduledOrderedProducts;
      requestOrderModel = scheduledOrderedProductsList;
      requestModelCountList = scheduledOrderedProductsCountList;
      requestModelStateList = scheduledOrderedProductsStateList;
      requestedOrderedProductsID = scheduledOrderedProductsID;
    } else if (drop == 'Cancelled') {
      dropDownValueColor = Colors.red;
      requestModel = canceledOrderedProducts;
      requestOrderModel = canceledOrderedProductsList;
      requestModelCountList = canceledOrderedProductsCountList;
      requestModelStateList = canceledOrderedProductsStateList;
    } else if (drop == 'Pending') {
      dropDownValueColor = Colors.orange;
      requestModel = pendingOrderedProducts;
      requestOrderModel = pendingOrderedProductsList;
      requestModelCountList = pendingOrderedProductsCountList;
      requestModelStateList = pendingOrderedProductsStateList;
      requestedOrderedProductsID = pendingOrderedProductsID;
    } else if (drop == 'All Requests') {
      dropDownValueColor = Colors.white;
      requestModel = myOrderedProducts;
      requestOrderModel = orderedProducts;
      requestModelCountList = orderedProductsCountList;
      requestModelStateList = orderedProductsStateList;
      requestedOrderedProductsID = allOrderedProductsID;
      log(requestOrderModel.toString());
    }
  }

  signOut(context) {
    CacheHelper.removeData(
      key: 'token',
    ).then((value) {
      if (value) {
        emit(DashboardLogoutState());
        navigateAndFinish(
          context,
          const LoginScreen(),
        );
      }
    });
  }

  changeSize(size) {
    if (size == 'isS') {
      isS = !isS;
      emit(ChangeSizedState());
    } else if (size == 'isM') {
      isM = !isM;
      emit(ChangeSizedState());
    } else if (size == 'isL') {
      isL = !isL;
      emit(ChangeSizedState());
    } else if (size == 'isXL') {
      isXL = !isXL;
      emit(ChangeSizedState());
    } else if (size == 'is2XL') {
      is2XL = !is2XL;
      emit(ChangeSizedState());
    } else if (size == 'is3XL') {
      is3XL = !is3XL;
      emit(ChangeSizedState());
    } else if (size == 'is4XL') {
      is4XL = !is4XL;
      emit(ChangeSizedState());
    } else if (size == 'is5XL') {
      is5XL = !is5XL;
      emit(ChangeSizedState());
    }
  }

  changeDate(day) {
    if (day == 'isSaturday') {
      isSaturday = !isSaturday;
      emit(ChangeDayState());
    } else if (day == 'isSunday') {
      isSunday = !isSunday;
      emit(ChangeDayState());
    } else if (day == 'isMonday') {
      isMonday = !isMonday;
      emit(ChangeDayState());
    } else if (day == 'isTuesday') {
      isTuesday = !isTuesday;
      emit(ChangeDayState());
    } else if (day == 'isWednesday') {
      isWednesday = !isWednesday;
      emit(ChangeDayState());
    } else if (day == 'isThursday') {
      isThursday = !isThursday;
      emit(ChangeDayState());
    } else if (day == 'isFriday') {
      isFriday = !isFriday;
      emit(ChangeDayState());
    }
  }

  removeProduct(pid) {
    List id = [];
    if (allProductsID.contains(pid)) {
      products.removeAt(productsID.indexOf(pid));
      productsID.remove(pid);
      allProductsID.remove(pid);
      log(products.toString());
      log(productsID.toString());
      log(allProductsID.toString());
      FirebaseFirestore.instance
          .collection('products')
          .doc(pid)
          .delete()
          .then((value) {
        emit(RemoveProductSuccessState());
        FirebaseFirestore.instance
            .collection('orders')
            .get()
            .then((value) {
              for (var element in value.docs) {
                if (element.data()['orderedProducts'] == pid) {
                  id.add(element.id);
                }
              }
              for (var ele in id) {
                FirebaseFirestore.instance
                    .collection('orders')
                    .doc(ele)
                    .delete()
                    .then((value) => emit(RemoveProductSuccessState()))
                    .catchError((err) {
                  log(err.toString());
                  emit(RemoveProductErrorState());
                });
              }
            })
            .then((value) => emit(RemoveProductSuccessState()))
            .catchError((err) {
              log(err.toString());
              emit(RemoveProductErrorState());
            });
      }).catchError((error) {
        emit(RemoveProductErrorState());
      });
    }
  }

  var caroIndex = 0;
  var productCaroIndex = 0;

  changeCarousel(index) {
    caroIndex = index;
    emit(ChangeCarouselState());
  }

  changeProductCarousel(index) {
    productCaroIndex = index;
    emit(ChangeCarouselState());
  }

  changeProductCarouselList() {
    emit(ChangeCarouselState());
  }

  changeToggleValue(val) {
    promoToggle = val;
    emit(ChangeToggleValueState());
  }

  changeDiscountValue(val) {
    discountToggle = val;
    emit(ChangeToggleValueState());
  }

  changeDeliveryValue(val) {
    deliveryToggle = val;
    emit(ChangeToggleValueState());
  }

  changeDialValue(val) {
    isDialOpen = val;
    emit(ChangeToggleValueState());
  }

  changePromoDiscountValue(val) {
    promoDiscountToggle = val;
    emit(ChangeToggleValueState());
  }

  createId(length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    math.Random _rnd = math.Random();
    String id = String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    emit(ChangeToggleValueState());
    return id;
  }

  changeLanguageValue(v, context) async {
    isEnglish = v;
    log(isEnglish.toString());
    CacheHelper.putBoolean(key: 'lang', value: isEnglish);
    emit(ChangeLanguageState());
  }

  void sendMessages(
      {@required String receiverId,
      @required String dateTime,
      @required String text}) {
    MessageModel model = MessageModel(
        senderId: loginModel.uId,
        receiverId: receiverId,
        dateTime: dateTime,
        text: text);

    FirebaseFirestore.instance
        .collection("users")
        .doc(loginModel.uId)
        .collection("chats")
        .doc(model.receiverId)
        .collection("messages")
        .add(model.toMap())
        .then((value) {
      emit(SellerSendMessagesSuccessState());
    }).catchError((error) {
      emit(SellerSendMessagesErrorState());
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(receiverId)
        .collection("chats")
        .doc(loginModel.uId)
        .collection("messages")
        .add(model.toMap())
        .then((value) {
      emit(SellerSendMessagesSuccessState());
    }).catchError((error) {
      emit(SellerSendMessagesErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({@required String receiverId}) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(loginModel.uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(SellerGetAllMessagesSuccessState());
    });
  }

  ProductUserModel umodel;

  getUid(String uid) async {
    // var uid;
    // for(var element in productsID){
    //   if(element==productId){
    //     uid= products[productsID.indexOf(element)].uid;
    //   }
    // }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      umodel = ProductUserModel.fromJson(value.data());
      // log(uid.toString());
      // log(value.data().toString());
      // log(value.data()['uId'].toString());
    });
  }

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  var address = '';
  Placemark place;

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    log(placemarks.toString());
    place = placemarks[0];
    address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    log(address);
  }

  userChangeDropValue(value, context) {
    EasyLocalization.of(context).locale.languageCode == 'en'
        ? userRegisterDropdownValueEn = value
        : userRegisterDropdownValueAr = value;
    emit(ShopRegisterChangeDropValueState());
  }

  Future<void> resetEmailAddress(
      {String newEmail, String oldEmail, String password, context}) async {
    var authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: oldEmail, password: password);
    await authResult.user.updateEmail(newEmail);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(authResult.user.uid)
        .update({
      'email': newEmail,
      'uId': authResult.user.uid,
    }).then((value) {
      CacheHelper.saveData(key: 'user', value: newEmail);
    });
    userLogin(context: context, email: newEmail, password: password);
  }

  Future<void> deleteUser({
    String uid,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'isEmailVerfied': false,
    }).then((value) {
      showToast(text: 'email deleted', state: ToastStates.success);
      emit(DeleteUserSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(DeleteUserErrorState());
    });
  }

  Future<void> undeleteUser({
    String uid,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'isEmailVerfied': true,
    }).then((value) {
      showToast(text: 'email undeleted', state: ToastStates.success);
      emit(UnDeleteUserSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(UnDeleteUserErrorState());
    });
  }
}

class ProductUserModel {
  String firstName;
  String secondName;
  String uId;
  String image;

  ProductUserModel({
    @required this.uId,
    @required this.firstName,
    @required this.secondName,
    @required this.image,
  });

  ProductUserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    firstName = json['firstName'];
    secondName = json['secondName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'firstName': firstName,
      'secondName': secondName,
    };
  }
}
