import 'dart:developer';
import 'package:buildcondition/buildcondition.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/orders/orders_model.dart';
import '../../../translations/locale_keys.g.dart';

class UserSellerChatScreen extends StatelessWidget {
  const UserSellerChatScreen({
    Key key,
    this.orderModel,
    this.index,
  }) : super(key: key);
  final OrdersModel orderModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    return Builder(builder: (context) {
      ShopCubit.get(context).getProductUid(orderModel.orderedProduct);
      log(ShopCubit.get(context).smodel.uId.toString());
      ShopCubit.get(context)
          .getMessages(receiverId: ShopCubit.get(context).smodel.uId);
      return BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage:
                          NetworkImage(ShopCubit.get(context).smodel.image),
                    ),
                    const SizedBox(
                      width: 7.0,
                    ),
                    Text(ShopCubit.get(context).smodel.organization)
                  ],
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
              ),
              body: BuildCondition(
                  condition: ShopCubit.get(context).messages.isNotEmpty,
                  builder: (context) => Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child: Column(
                            children: [
                              Expanded(
                                child: Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView.separated(
                                          itemBuilder: (context, index) {
                                            var message = ShopCubit.get(context)
                                                .messages[index];
                                            if (ShopCubit.get(context)
                                                    .loginModel
                                                    .uId ==
                                                message.senderId) {
                                              return buildMyMessage(message);
                                            }

                                            return buildMessage(message);
                                          },
                                          separatorBuilder: (context, state) =>
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                          itemCount:
                                              ShopCubit.get(context).messages.length),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Center(
                                child: Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  height: 50.0,
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[300],
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: TextFormField(
                                            controller: messageController,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: LocaleKeys
                                                  .chatScreen_typeMessageHere
                                                  .tr(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50.0,
                                        color: Colors.grey,
                                        child: MaterialButton(
                                          onPressed: () {
                                            ShopCubit.get(context).sendMessages(
                                                receiverId: ShopCubit.get(context)
                                                    .smodel
                                                    .uId,
                                                dateTime: DateTime.now().toString(),
                                                text: messageController.text);
                                            messageController.text = '';
                                          },
                                          child: const Icon(
                                            Icons.send,
                                            color: Colors.white,
                                          ),
                                          color: Colors.grey,
                                          minWidth: 1.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  fallback: (context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      LocaleKeys.chatScreen_noMessagesYet.tr(),
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: 50.0,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[300],
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: TextFormField(
                                        controller: messageController,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: LocaleKeys
                                                .chatScreen_typeMessageHere
                                                .tr()),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50.0,
                                    color: Colors.grey,
                                    child: MaterialButton(
                                      onPressed: () {
                                        ShopCubit.get(context).sendMessages(
                                            receiverId: ShopCubit.get(context)
                                                .smodel
                                                .uId,
                                            dateTime: DateTime.now().toString(),
                                            text: messageController.text);
                                        messageController.text = '';
                                      },
                                      child: const Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),
                                      color: Colors.grey,
                                      minWidth: 1.0,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )),
            );
          });
    });
  }

  Widget buildMessage(model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
            ),
            color: Colors.grey[400],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 10.0,
          ),
          child: Text(model.text),
        ),
      );

  Widget buildMyMessage(model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
            ),
            color: Colors.grey[400],
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 10.0,
          ),
          child: Text(model.text),
        ),
      );
}
