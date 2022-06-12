import 'dart:developer' as dev;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../layout/dashboard_layout/cubit/cubit.dart';
import '../../layout/shop_app/cubit/cubit.dart';
import '../../models/orders/orders_model.dart';
import '../../models/shop_app/products_model.dart';
import '../../modules/service_provider/seller_product/seller_product.dart';
import '../../modules/service_provider/seller_request/seller_request.dart';
import '../../modules/user/check_out/check_out.dart';
import '../../modules/user/home_selected_product/selected_prodct.dart';
import '../../modules/user/selected_category_screen/selected_category_screen.dart';
import '../../translations/locale_keys.g.dart';
import '../styles/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  double height = double.infinity,
  IconData icon,
  background = Colors.black,
  bool isUpperCase = true,
  bool isIcon = false,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) {
  return Container(
    width: width,
    height: height,
    child: MaterialButton(
      onPressed: function,
      child: isIcon
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  isUpperCase ? text.toUpperCase() : text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            )
          : Text(
              isUpperCase ? text.toUpperCase() : text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        radius,
      ),
      color: background,
    ),
  );
}

Widget defaultButton2({
  double width,
  double height,
  background = defaultColor2,
  bool isUpperCase = true,
  double radius = 3.0,
  IconData ico,
  @required Function function,
  @required String text,
}) {
  return Container(
    width: width,
    height: height,
    child: MaterialButton(
      onPressed: function,
      child: ico != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  ico,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  isUpperCase ? text.toUpperCase() : text,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            )
          : Text(
              isUpperCase ? text.toUpperCase() : text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        radius,
      ),
      color: background,
    ),
  );
}

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  ValueChanged<String> onChange,
  Function onTap,
  bool isPassword = false,
  bool isValidate = false,
  bool isPrefixText = false,
  Function validate,
  @required String label,
  @required prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
  double borderRadius = 20.0,
  double fontSize = 16.0,
}) =>
    TextFormField(
      style: TextStyle(fontSize: fontSize),
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: isValidate ? validate : null,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black26,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        labelText: label,
        labelStyle: TextStyle(fontSize: fontSize),
        prefixIcon: isPrefixText
            ? prefix
            : Icon(
                prefix,
              ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black26,
              width: 2.5,
            ),
            borderRadius: BorderRadius.circular(borderRadius)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );

Widget searchFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  bool isValidate = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: isValidate ? validate : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)),
      ),
    );

Widget categoryButton({
  color = Colors.lightBlue,
  @required text,
  @required iconPath,
  @required context,
  width = 26.0,
  @required mmodel,
  @required mmodelID,
  @required name,
}) =>
    MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      onPressed: () {
        navigateTo(
            context,
            SelectedCategoryScreen(
              mmodel: mmodel,
              mmodelID: mmodelID,
              nameOfCategory: name,
            ));
      },
      color: color,
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          const Spacer(),
          Image.asset(iconPath, width: width, fit: BoxFit.cover),
        ],
      ),
    );

Widget myDivider({height = 1.0}) => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: height,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

void showToast({
  @required String text,
  @required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget buildListProduct({
  @required ShopProductsModel model,
  @required idList,
  @required index,
  @required context,
  bool isOldPrice = true,
}) {
  dev.log(ShopCubit.get(context).sportCategoryID.toString());
  dev.log(idList[index].toString());
  var color = Colors.deepOrange;
  var category = 'Men\'s';
  if (ShopCubit.get(context).menCategoryID.contains(idList[index])) {
    color = Colors.deepOrange;
    category = 'Men\'s';
  } else if (ShopCubit.get(context).womenCategoryID.contains(idList[index])) {
    color = Colors.pink;
    category = 'Women\'s';
  } else if (ShopCubit.get(context).shoeCategoryID.contains(idList[index])) {
    color = Colors.purple;
    category = 'Shoes';
  } else if (ShopCubit.get(context).bagCategoryID.contains(idList[index])) {
    color = Colors.teal;
    category = 'Bags';
  } else if (ShopCubit.get(context).sportCategoryID.contains(idList[index])) {
    color = Colors.green;
    category = 'Sporting';
  } else if (ShopCubit.get(context)
      .childrenCategoryID
      .contains(idList[index])) {
    color = Colors.blue;
    category = 'Children';
  } else if (ShopCubit.get(context)
      .accessoriesCategoryID
      .contains(idList[index])) {
    color = Colors.red;
    category = 'Accessories';
  }
  return InkWell(
    onTap: () {
      navigateTo(
          context,
          HomeSelectedProductScreen(
            mmodel: model,
            mmodelID: idList,
            category: category,
            color: color,
            productIndex: index,
          ));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image.first),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      LocaleKeys.userAccountScreen_orderDiscount.tr() + ':',
                      style: const TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price - ((model.price / 100) * model.discount)}',
                        // model.price.toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          model.price.toString(),
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          // ShopCubit.get(context).changeFavorites(model.id);
                          ShopCubit.get(context)
                              .inFavorites(pid: idList[index]);
                          ShopCubit.get(context).updateData();
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopCubit.get(context)
                                  .favorites
                                  .contains(idList[index])
                              ? defaultColor
                              : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildSearchListProduct({
  @required ShopProductsModel model,
  @required idList,
  @required index,
  @required context,
  bool isOldPrice = true,
}) {
  return InkWell(
    onTap: () {
      navigateTo(
          context,
          HomeSelectedSearchProductScreen(
            mmodel: model,
            mmodelID: idList,
            productIndex: index,
          ));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120.0,
        width: MediaQuery.of(context).size.width / 2,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Image(
                    image: NetworkImage(model.image.first),
                    height: 120.0,
                  ),
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      LocaleKeys.userAccountScreen_orderDiscount.tr() + ':',
                      style: const TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price - ((model.price / 100) * model.discount)}',
                        // model.price.toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          model.price.toString(),
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          // ShopCubit.get(context).changeFavorites(model.id);
                          ShopCubit.get(context)
                              .inFavorites(pid: idList[index]);
                          ShopCubit.get(context).updateData();
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopCubit.get(context)
                                  .favorites
                                  .contains(idList[index])
                              ? defaultColor
                              : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

buildOrdersListProduct({
  @required List<OrdersModel> model,
  @required index,
  @required context,
  bool isOldPrice = true,
}) {
  SingleChildScrollView(
    child: Column(
      children: [
        // const SizedBox(height: 15.0,),
        const Padding(
          padding: EdgeInsets.all(12.0),
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       'Order #${model[index].id}',
          //       style: const TextStyle(
          //         fontSize: 14.0,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     Text(
          //       '${model[index].status}',
          //       style: const TextStyle(
          //         fontSize: 14.0,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ],
          // ),
        ),
        model.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => Container(
                    height: 160.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                      border: Border.all(
                        width: 2.0,
                        color: Colors.black,
                      ),
                    ),
                    child: Stack(
                      children: [
                        const SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width - 240.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        width: 2.0, color: Colors.black)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: const Icon(Icons.arrow_back_ios),
                                      left: 0.0,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              7.0,
                                    ),
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        model[index].orderImage,
                                      ),
                                    ),
                                    Positioned(
                                      child:
                                          const Icon(Icons.arrow_forward_ios),
                                      right: 0.0,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              7.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          child: Text(model[index].orderedProduct),
                          top: MediaQuery.of(context).size.height / 15,
                          right: MediaQuery.of(context).size.width / 20,
                        ),
                        Positioned(
                          child: Text('\$ ${model[index].orderCost}'),
                          top: MediaQuery.of(context).size.height / 10,
                          right: MediaQuery.of(context).size.width / 20,
                        ),
                        Positioned(
                          child: Text(
                              '${model[index].orderedProductsCount ?? ''}'),
                          top: MediaQuery.of(context).size.height / 8,
                          right: MediaQuery.of(context).size.width / 20,
                        ),
                        Positioned(
                          top: 10.0,
                          right: 10.0,
                          child: Container(
                            height: 30.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: DashboardCubit.get(context)
                                            .requestModelStateList[index] ==
                                        'Completed'
                                    ? Colors.green
                                    : DashboardCubit.get(context)
                                                .requestModelStateList[index] ==
                                            'Scheduled'
                                        ? Colors.blue
                                        : DashboardCubit.get(context)
                                                        .requestModelStateList[
                                                    index] ==
                                                'Pending'
                                            ? Colors.orange
                                            : DashboardCubit.get(context)
                                                            .requestModelStateList[
                                                        index] ==
                                                    'Cancelled'
                                                ? Colors.red
                                                : Colors.white),
                            child: Center(
                                child: Text(
                                    DashboardCubit.get(context)
                                        .requestModelStateList[index],
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10.0,
                  ),
                  itemCount: model.length,
                ),
              )
            : const Center(
                child: Text('No Requests Yet'),
              ),
      ],
    ),
  );
}

class BuildListProduct2 extends StatefulWidget {
  final ShopProductsModel model;
  final String idList;
  final String sizee;
  final BuildContext context;
  final int index;
  final bool flag;
  final Function validate;

  const BuildListProduct2(
      {Key key,
      this.model,
      this.sizee,
      this.idList,
      this.context,
      this.index,
      this.flag,
      this.validate})
      : super(key: key);

  @override
  State<BuildListProduct2> createState() => _BuildListProduct2State();
}

class _BuildListProduct2State extends State<BuildListProduct2> {
  int count = 1;
  List mCounter;
  var promoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (ShopCubit.get(context).counters.isNotEmpty) {
      if (ShopCubit.get(context).counters.length <
          ShopCubit.get(context).cartModel.length) {
        ShopCubit.get(context).counters.add(count);
      } else {
        ShopCubit.get(context)
            .counters
            .removeAt(ShopCubit.get(context).cartModel.indexOf(widget.model));
        ShopCubit.get(context).counters.insert(
            ShopCubit.get(context).cartModel.indexOf(widget.model), count);
      }
    } else {
      ShopCubit.get(context).counters.add(count);
    }

    // mCounter =ShopCubit.get(context).counters;
    var price = widget.model.isShipping
        ? (widget.model.price -
                ((widget.model.price / 100) * widget.model.discount)) +
            int.parse(widget.model.shippingPrice)
        : (widget.model.price -
            ((widget.model.price / 100) * widget.model.discount));
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: SizedBox(
              height: 150.0,
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        widget.model.image.first,
                        height: 130.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${widget.model.name} x$count',
                              maxLines: 2,
                              // overflow: TextOverflow.,
                            ),
                            Row(
                              children: [
                                Text('LE ${price * count}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    )),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                widget.sizee != ''
                                    ? buildSizeCircle(
                                        size: widget.sizee,
                                        state: false,
                                        innerSize: 15.0,
                                        outerSize: 17.0,
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25.0),
                              child: defaultButton(
                                function: () {
                                  dev.log(widget.model.uid.toString());
                                  navigateTo(
                                      context,
                                      CheckoutScreen(
                                        count: count,
                                        size: widget.sizee,
                                        index: widget.index,
                                        id: widget.idList,
                                        price: (price * count).toInt(),
                                        image: widget.model.image.first,
                                        model: widget.model,
                                      ));
                                },
                                text: LocaleKeys.userCartScreen_checkout.tr(),
                                width: 120.0,
                                height: 30.0,
                                radius: 12.0,
                              ),
                            )
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //     top: 8.0,
                            //     bottom: 8.0,
                            //     right: 8.0,
                            //   ),
                            //   child: SizedBox(
                            //     width: 150.0,
                            //     height: 50.0,
                            //     child: defaultFormField(
                            //       controller: promoController,
                            //       type: TextInputType.text,
                            //       validate: widget.validate,
                            //       label: 'Promo Code',
                            //       prefix: Icons.local_offer,
                            //       fontSize: 12.0,
                            //     ),
                            //   ),
                            // ),
                            // defaultButton(
                            //     function: () {
                            //       bool flag = false;
                            //       dev.log(promoController.text);
                            //       if (ShopCubit.get(context)
                            //           .promoCodesList
                            //           .contains(promoController.text)) {
                            //         flag = true;
                            //       } else {
                            //         flag = false;
                            //       }
                            //
                            //       if (flag) {
                            //         showToast(
                            //             text: 'activated promo code',
                            //             state: ToastStates.success);
                            //         price = price -
                            //             ((widget.model.price / 100) *
                            //                 ShopCubit.get(context).discountList[
                            //                     ShopCubit.get(context)
                            //                         .promoCodesList
                            //                         .indexOf(promoController.text)]);
                            //         ShopCubit.get(context).changeCartPrice();
                            //         dev.log(price.toString());
                            //       } else {
                            //         showToast(
                            //             text: 'Wrong promo code',
                            //             state: ToastStates.error);
                            //       }
                            //     },
                            //     text: 'Apply',
                            //     height: 29.0,
                            //     width: 80.0,
                            //     radius: 14.0),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {
                                ShopCubit.get(context).removeCart(
                                    ShopCubit.get(context).cart[widget.index]);
                                ShopCubit.get(context).getCart();
                              },
                              icon: const Icon(Icons.close)),
                          SizedBox(
                            child: FloatingActionButton(
                              onPressed: () {
                                count++;
                                ShopCubit.get(context).counters.removeAt(
                                    ShopCubit.get(context)
                                        .cartModel
                                        .indexOf(widget.model));
                                ShopCubit.get(context).counters.insert(
                                    ShopCubit.get(context)
                                        .cartModel
                                        .indexOf(widget.model),
                                    count);
                                ShopCubit.get(context).changeCount();
                                dev.log(
                                    ShopCubit.get(context).counters.toString());
                                ShopCubit.get(context).counters.removeAt(0);

                                // print(count.toString());
                                // ShopCubit.get(context).changeCount();
                              },
                              backgroundColor: Colors.white,
                              child: const Icon(
                                Icons.add_circle_outline,
                                color: Colors.black,
                              ),
                            ),
                            width: 35.0,
                            height: 35.0,
                          ),
                          Text(count.toString()),
                          SizedBox(
                            child: FloatingActionButton(
                              onPressed: () {
                                if (count <= 1) {
                                  count = 1;
                                  ShopCubit.get(context).counters.removeAt(
                                      ShopCubit.get(context)
                                          .cartModel
                                          .indexOf(widget.model));
                                  ShopCubit.get(context).counters.insert(
                                      ShopCubit.get(context)
                                          .cartModel
                                          .indexOf(widget.model),
                                      count);
                                  ShopCubit.get(context).changeCount();
                                  dev.log(ShopCubit.get(context)
                                      .counters
                                      .toString());
                                  ShopCubit.get(context).counters.removeAt(0);
                                } else {
                                  count--;
                                  ShopCubit.get(context).counters.removeAt(
                                      ShopCubit.get(context)
                                          .cartModel
                                          .indexOf(widget.model));
                                  ShopCubit.get(context).counters.insert(
                                      ShopCubit.get(context)
                                          .cartModel
                                          .indexOf(widget.model),
                                      count);
                                  ShopCubit.get(context).changeCount();
                                  dev.log(ShopCubit.get(context)
                                      .counters
                                      .toString());
                                  ShopCubit.get(context).counters.removeAt(0);
                                }
                              },
                              backgroundColor: Colors.white,
                              child: const Icon(
                                Icons.remove_circle_outline,
                                color: Colors.black,
                              ),
                            ),
                            width: 35.0,
                            height: 35.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildCategoryButton(String imagePath) {
  return Stack(
    alignment: Alignment.center,
    children: [
      const SizedBox(
        height: 150.0,
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
        ),
      ),
      Positioned(
          top: 20.0,
          child: Image.asset(
            imagePath,
            width: 70,
          )),
    ],
  );
}

Widget buildGridProduct({
  @required context,
  @required List<ShopProductsModel> model,
  @required index,
  @required idList,
  @required category,
  @required color,
}) =>
    InkWell(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 18.0,
          left: 15.0,
          right: 15.0,
          bottom: 15.0,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: const Color(0xffF7F7F7),
              borderRadius: BorderRadius.circular(14.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: NetworkImage(
                        model[index].image.first,
                      ),
                      width: double.infinity,
                      height: 160.0,
                    ),
                  ),
                  if (model[index].discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model[index].name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    Row(
                      children: [
                        model[index].discount != 0
                            ? Text(
                                '${model[index].price - ((model[index].price / 100) * model[index].discount)}',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: defaultColor,
                                ),
                              )
                            : Text(
                                '${model[index].price}',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: defaultColor,
                                ),
                              ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (model[index].discount != 0)
                          Text(
                            '${model[index].price}',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey[500],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .inFavorites(pid: idList[index]);
                            // ShopCubit.get(context).updateData();
                          },
                          icon: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: ShopCubit.get(context)
                                    .favorites
                                    .contains(idList[index])
                                ? defaultColor
                                : Colors.grey,
                            child: const Icon(
                              Icons.favorite_border,
                              size: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        navigateTo(
            context,
            HomeSelectedProductScreen(
              productIndex: index,
              mmodel: model[index],
              mmodelID: idList,
              category: category,
              color: color,
            ));
      },
    );

// Widget buildAllProducts({
//   @required width,
//   @required List<ShopProductsModel> model,
// }) =>;
class BuildAllProducts extends StatefulWidget {
  const BuildAllProducts(
      {Key key, this.screenWidth, this.model, this.modelIDList})
      : super(key: key);
  final double screenWidth;
  final List<ShopProductsModel> model;
  final List modelIDList;

  @override
  State<BuildAllProducts> createState() => _BuildAllProductsState();
}

class _BuildAllProductsState extends State<BuildAllProducts> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return widget.model.isNotEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(LocaleKeys.dashboardScreen_allProducts.tr(),style: Theme.of(context).textTheme.headline4,),
                      ],
                    ),
                  ),
                  Container(
                    width: (width *0.75),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListView.separated(
                          physics: const PageScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                DashboardCubit.get(context).productCaroIndex = 0;
                                navigateTo(
                                    context,
                                    SellerProduct(
                                      models: widget.model[index],
                                      index: index,
                                      modelId: widget.modelIDList[index],
                                    ));
                              },
                              child: Container(
                                height: 160.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white,
                                  border:
                                      Border.all(width: 2.0, color: Colors.black),
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width:
                                                MediaQuery.of(context).size.width /
                                                    4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              border: Border.all(
                                                width: 2.0,
                                                color: Colors.black,
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                CarouselSlider(
                                                  items: widget.model[index].image
                                                          .isEmpty
                                                      ? const [Icon(Icons.image)]
                                                      : widget.model[index].image
                                                          .map((e) => Image.network(
                                                                e,
                                                                width: 110,
                                                              ))
                                                          .toList(),
                                                  options: CarouselOptions(
                                                    aspectRatio: 1.0,
                                                    height: 130,
                                                    viewportFraction: 1.0,
                                                    enlargeCenterPage: false,
                                                    initialPage: 0,
                                                    enableInfiniteScroll: true,
                                                    reverse: false,
                                                    autoPlay: false,
                                                    autoPlayInterval:
                                                        const Duration(seconds: 3),
                                                    autoPlayAnimationDuration:
                                                        const Duration(seconds: 1),
                                                    autoPlayCurve:
                                                        Curves.fastOutSlowIn,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                  ),
                                                  // carouselController: caroController,
                                                ),
                                                Positioned(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      16.0,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.52,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                      right: 1.0,
                                                      left: 2.0,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: const [
                                                        Icon(
                                                          Icons.arrow_back_ios,
                                                          color: Colors.black,
                                                          size: 30.0,
                                                        ),
                                                        Icon(
                                                          Icons.arrow_forward_ios,
                                                          color: Colors.black,
                                                          size: 30.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 20.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 30.0,
                                            width: 80.0,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              color: widget.model[index].state ==
                                                      'Approved'
                                                  ? Colors.green
                                                  : widget.model[index].state ==
                                                          'Pending'
                                                      ? Colors.orange
                                                      : widget.model[index].state ==
                                                              'Cancelled'
                                                          ? Colors.red
                                                          : Colors.white,
                                            ),
                                            child: Center(
                                              child: Text(
                                                widget.model[index].state ==
                                                        'Approved'
                                                    ? EasyLocalization.of(context)
                                                                .locale
                                                                .languageCode ==
                                                            'en'
                                                        ? 'Approved'
                                                        : 'تم التأكد'
                                                    : widget.model[index].state ==
                                                            'Pending'
                                                        ? EasyLocalization.of(
                                                                        context)
                                                                    .locale
                                                                    .languageCode ==
                                                                'en'
                                                            ? 'Pending'
                                                            : 'قيد الانتظار'
                                                        : widget.model[index]
                                                                    .state ==
                                                                'Cancelled'
                                                            ? EasyLocalization.of(
                                                                            context)
                                                                        .locale
                                                                        .languageCode ==
                                                                    'en'
                                                                ? 'Cancelled'
                                                                : 'ملغي'
                                                            : '',
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(widget.model[index].name),
                                          Text('\$ ${widget.model[index].price}'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10.0,
                          ),
                          itemCount: widget.model.length,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Center(
            child: Text(LocaleKeys.dashboardScreen_noProductsError.tr()),
          );
  }
}

Widget buildRequests({
  @required width,
  @required context,
  @required List<ShopProductsModel> model,
  @required List<OrdersModel> ordersModel,
  @required List countList,
  @required List id,
}) =>
    Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width - (width / 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // const SizedBox(height: 15.0,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 73.0,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  const Icon(
                                    Icons.list,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      LocaleKeys.signUpScreen_select_City.tr(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: EasyLocalization.of(context)
                                          .locale
                                          .languageCode ==
                                      'en'
                                  ? DashboardCubit.get(context)
                                      .itemsEn
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList()
                                  : DashboardCubit.get(context)
                                      .itemsAr
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                              value: EasyLocalization.of(context)
                                          .locale
                                          .languageCode ==
                                      'en'
                                  ? DashboardCubit.get(context).dropDownValueEn
                                  : DashboardCubit.get(context).dropDownValueAr,
                              onChanged: (value) {
                                DashboardCubit.get(context)
                                    .changeDropButtonValue(value, context);
                                // selectedValue = value as String;
                              },
                              icon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                                size: 20.0,
                              ),
                              iconSize: 14,
                              iconEnabledColor: Colors.black,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonWidth: 160,
                              buttonPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  width: 2.5,
                                  color: Colors.black26,
                                ),
                                color: Colors.white,
                              ),
                              itemHeight: 40,
                              itemPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              dropdownMaxHeight: 200,
                              dropdownWidth: 200,
                              dropdownPadding: null,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                              scrollbarRadius: const Radius.circular(40),
                              scrollbarThickness: 6,
                              scrollbarAlwaysShow: true,
                              offset: const Offset(0, 0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                model.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              DashboardCubit.get(context).productCaroIndex = 0;
                              navigateTo(
                                context,
                                SellerRequest(
                                  models: model[index],
                                  orderModel: ordersModel[index],
                                  state: DashboardCubit.get(context)
                                      .requestModelStateList[index],
                                  index: index,
                                  id: id[index],
                                  dropValue: EasyLocalization.of(context)
                                              .locale
                                              .languageCode ==
                                          'en'
                                      ? DashboardCubit.get(context)
                                          .dropDownValueEn
                                      : DashboardCubit.get(context)
                                          .dropDownValueAr,
                                ),
                              );
                            },
                            child: Container(
                              height: 160.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                                border: Border.all(
                                  width: 2.0,
                                  color: Colors.black,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              border: Border.all(
                                                  width: 2.0,
                                                  color: Colors.black)),
                                          child: Stack(
                                            children: [
                                              CarouselSlider(
                                                items: model[index]
                                                        .image
                                                        .isEmpty
                                                    ? const [Icon(Icons.image)]
                                                    : model[index]
                                                        .image
                                                        .map((e) =>
                                                            Image.network(
                                                              e,
                                                              width: 110.0,
                                                            ))
                                                        .toList(),
                                                options: CarouselOptions(
                                                  aspectRatio: 1.0,
                                                  height: 130,
                                                  viewportFraction: 1.0,
                                                  enlargeCenterPage: false,
                                                  initialPage: 0,
                                                  enableInfiniteScroll: true,
                                                  reverse: false,
                                                  autoPlay: false,
                                                  autoPlayInterval:
                                                      const Duration(
                                                          seconds: 3),
                                                  autoPlayAnimationDuration:
                                                      const Duration(
                                                          seconds: 1),
                                                  autoPlayCurve:
                                                      Curves.fastOutSlowIn,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                ),
                                                // carouselController: caroController,
                                              ),
                                              Positioned(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    16.0,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.52,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    right: 1.0,
                                                    left: 2.0,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: const [
                                                      Icon(
                                                        Icons.arrow_back_ios,
                                                        color: Colors.black,
                                                        size: 30.0,
                                                      ),
                                                      Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.black,
                                                        size: 30.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 30.0,
                                          width: 100.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              color: DashboardCubit.get(context)
                                                              .requestModelStateList[
                                                          index] ==
                                                      'Completed'
                                                  ? Colors.green
                                                  : DashboardCubit.get(context)
                                                                  .requestModelStateList[
                                                              index] ==
                                                          'Scheduled'
                                                      ? Colors.blue
                                                      : DashboardCubit.get(
                                                                          context)
                                                                      .requestModelStateList[
                                                                  index] ==
                                                              'Pending'
                                                          ? Colors.orange
                                                          : DashboardCubit.get(
                                                                              context)
                                                                          .requestModelStateList[
                                                                      index] ==
                                                                  'Cancelled'
                                                              ? Colors.red
                                                              : Colors.white),
                                          child: Center(
                                            child: Text(
                                              DashboardCubit.get(context)
                                                              .requestModelStateList[
                                                          index] ==
                                                      'Completed'
                                                  ? EasyLocalization.of(context)
                                                              .locale
                                                              .languageCode ==
                                                          'en'
                                                      ? 'Completed'
                                                      : 'مكتمل'
                                                  : DashboardCubit.get(context)
                                                                  .requestModelStateList[
                                                              index] ==
                                                          'Scheduled'
                                                      ? EasyLocalization.of(context)
                                                                  .locale
                                                                  .languageCode ==
                                                              'en'
                                                          ? 'Scheduled'
                                                          : 'مجدول'
                                                      : DashboardCubit.get(context)
                                                                      .requestModelStateList[
                                                                  index] ==
                                                              'Pending'
                                                          ? EasyLocalization.of(context)
                                                                      .locale
                                                                      .languageCode ==
                                                                  'en'
                                                              ? 'Pending'
                                                              : 'معلق'
                                                          : DashboardCubit.get(context)
                                                                      .requestModelStateList[index] ==
                                                                  'Cancelled'
                                                              ? EasyLocalization.of(context).locale.languageCode == 'en'
                                                                  ? 'Cancelled'
                                                                  : 'ملغي'
                                                              : null,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(model[index].name),
                                        Text('\$ ${model[index].price}'),
                                        Text('${countList[index] ?? ''}'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10.0,
                          ),
                          itemCount: model.length,
                        ),
                      )
                    :  Center(
                        child: Text(LocaleKeys.alerts_noOrdersYet.tr()),
                      ),
              ],
            ),
          ),
        ),
      ),
    );

Widget buildRecommendedItem({
  @required context,
  @required List<ShopProductsModel> model,
  @required index,
  @required idList,
}) =>
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 180.0,
        decoration: BoxDecoration(
          color: const Color(0xffF7F7F7),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: NetworkImage(
                      model[index].image.first,
                    ),
                    width: double.infinity,
                    height: 160.0,
                  ),
                ),
                if (model[index].discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model[index].name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      model[index].discount != 0
                          ? Text(
                              '${model[index].price - ((model[index].price / 100) * model[index].discount)}',
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: defaultColor,
                              ),
                            )
                          : Text(
                              '${model[index].price}',
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: defaultColor,
                              ),
                            ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model[index].discount != 0)
                        Text(
                          '${model[index].price}',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey[500],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          // print(index);
                          ShopCubit.get(context)
                              .inFavorites(pid: idList[index]);
                          // ShopCubit.get(context).updateData();
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopCubit.get(context)
                                  .favorites
                                  .contains(idList[index])
                              ? defaultColor
                              : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

Widget buildSizeCircle(
    {String size,
    bool state,
    outerSize = 22.0,
    innerSize = 20.0,
    color = Colors.black}) {
  if (!state) {
    return CircleAvatar(
      backgroundColor: color,
      child: CircleAvatar(
        child: Text(
          size,
          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        radius: innerSize,
        backgroundColor: Colors.white,
      ),
      radius: outerSize,
    );
  } else {
    return CircleAvatar(
      backgroundColor: color,
      child: Text(
        size,
        style: const TextStyle(fontSize: 14.0),
      ),
      radius: innerSize,
    );
  }
}

Widget textFieldCardNumber({@required bool first, last, @required context}) {
  return Container(
    color: Colors.black,
    width: MediaQuery.of(context).size.width / 5.0,
    height: 60.0,
    child: AspectRatio(
      aspectRatio: 1.0,
      child: TextField(
        autofocus: true,
        onChanged: (value) {
          if (value.length == 4 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        showCursor: false,
        readOnly: false,
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        keyboardType: TextInputType.number,
        maxLength: 4,
        decoration: InputDecoration(
          counter: const Offstage(),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.white),
              borderRadius: BorderRadius.circular(13)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.deepOrange),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),
  );
}

Widget textFieldDateValidation(
    {@required bool first, last, @required context}) {
  return Container(
    color: Colors.black,
    width: MediaQuery.of(context).size.width / 6,
    height: 50,
    child: AspectRatio(
      aspectRatio: 1.0,
      child: TextField(
        autofocus: true,
        onChanged: (value) {
          if (value.length == 4 && last == false) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        showCursor: false,
        readOnly: false,
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        keyboardType: TextInputType.number,
        maxLength: 2,
        decoration: InputDecoration(
          counter: const Offstage(),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.white),
              borderRadius: BorderRadius.circular(13)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.deepOrange),
              borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),
  );
}
