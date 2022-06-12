import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:egyoutfitweb/modules/user/profile/user_seller_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/orders/orders_model.dart';
import '../../../shared/components/components.dart';
import '../../../translations/locale_keys.g.dart';

class UserOpenedOrderScreen extends StatelessWidget {
  const UserOpenedOrderScreen({
    Key key,
    this.orderModel,
    this.index,
  }) : super(key: key);
  final OrdersModel orderModel;
  final int index;

  @override
  Widget build(BuildContext context) {
      return Builder(
        builder: (context) {
          ShopCubit.get(context)
              .getProductUid(orderModel.orderedProduct);
          log(ShopCubit.get(context).smodel.uId.toString());
          ShopCubit.get(context)
              .getMessages(receiverId: ShopCubit.get(context).smodel.uId);
          return BlocConsumer<ShopCubit, ShopStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return  SafeArea(
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15.0),
                                          border: Border.all(
                                            width: 2.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Image(
                                          image: NetworkImage(orderModel.orderImage),
                                          // carouselController: caroController,
                                          height:
                                              MediaQuery.of(context).size.height / 3,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(LocaleKeys.userAccountScreen_orderName
                                                    .tr() +
                                                ':'),
                                            Text(orderModel.orderName),
                                            const Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8.0,
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ShopCubit.get(context)
                                                              .ordersModel[index]
                                                              .pState ==
                                                          'Pending'
                                                      ? Colors.orange
                                                      : ShopCubit.get(context)
                                                                  .ordersModel[index]
                                                                  .pState ==
                                                              'Scheduled'
                                                          ? Colors.blue
                                                          : ShopCubit.get(context)
                                                                      .ordersModel[
                                                                          index]
                                                                      .pState ==
                                                                  'Cancelled'
                                                              ? Colors.red
                                                              : ShopCubit.get(context)
                                                                          .ordersModel[
                                                                              index]
                                                                          .pState ==
                                                                      'Completed'
                                                                  ? Colors.green
                                                                  : Colors.orange,
                                                  borderRadius: BorderRadius.circular(
                                                    14.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 8.0,
                                                      right: 8.0,
                                                      top: 4.0,
                                                      bottom: 4.0),
                                                  child: Center(
                                                    child: Text(
                                                      ShopCubit.get(context)
                                                          .ordersModel[index]
                                                          .pState,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              LocaleKeys.userAccountScreen_orderCost
                                                      .tr() +
                                                  ':  ',
                                            ),
                                            Text(
                                              orderModel.orderedProductsCount
                                                  .toString(),
                                            ),
                                          ],
                                        ),
                                        orderModel.orderPromoDiscount.isEmpty
                                            ? Row(
                                                children: [
                                                  Text(LocaleKeys
                                                          .userAccountScreen_orderDiscount
                                                          .tr() +
                                                      ':  '),
                                                  const Text('No Discount'),
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  Text(LocaleKeys
                                                          .userAccountScreen_orderDiscount
                                                          .tr() +
                                                      ':  '),
                                                  Row(
                                                    children: orderModel
                                                        .orderPromoDiscount
                                                        .map((e) =>
                                                            Text(e.toString() + '% , '))
                                                        .toList(),
                                                  )
                                                ],
                                              ),
                                        Row(
                                          children: [
                                            Text(LocaleKeys.userAccountScreen_orderSize
                                                    .tr() +
                                                ':  '),
                                            Text(orderModel.orderSize.toString()),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(LocaleKeys.userAccountScreen_orderCost
                                                    .tr() +
                                                ':  '),
                                            Text(orderModel.orderCost.toString() +
                                                ' LE'),
                                          ],
                                        ),
                                        orderModel.orderPromoDiscount.isNotEmpty
                                            ? Row(
                                                children: [
                                                  Text(
                                                    LocaleKeys
                                                            .userAccountScreen_orderPromoCode
                                                            .tr() +
                                                        ':  ',
                                                  ),
                                                  Row(
                                                    children: orderModel.orderPromo
                                                        .map((e) =>
                                                            Text(e.toString() + ' , '))
                                                        .toList(),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  Text(
                                                    LocaleKeys
                                                            .userAccountScreen_orderPromoCode
                                                            .tr() +
                                                        ':  ',
                                                  ),
                                                  const Text('No promo'),
                                                ],
                                              ),
                                        Row(
                                          children: [
                                            Text(
                                              LocaleKeys.userAccountScreen_orderCustomer
                                                      .tr() +
                                                  ':  ',
                                            ),
                                            Text(orderModel.firstName),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              LocaleKeys.userAccountScreen_orderAddress
                                                      .tr() +
                                                  ':  ',
                                            ),
                                            Text(
                                              orderModel.address,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              LocaleKeys.userAccountScreen_orderPhone
                                                      .tr() +
                                                  ':  ',
                                            ),
                                            Text(
                                              orderModel.phoneNumber,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              LocaleKeys
                                                      .userAccountScreen_orderOtherPhone
                                                      .tr() +
                                                  ':  ',
                                            ),
                                            Text(
                                              orderModel.otherPhoneNumber,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50.0),
                                              child: defaultButton(
                                                function: () {
                                                  navigateTo(context, UserSellerChatScreen(
                                                     orderModel: orderModel,
                                                    index: index,
                                                  ));
                                                },
                                                text: 'Send Message',
                                                height: 50.0,
                                                radius: 14.0,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              );
            },
          );
        }
      );
    }


  buildDiscount(List list) {
    for (var element in list) {
      Text((element.toString()));
    }
  }
}
