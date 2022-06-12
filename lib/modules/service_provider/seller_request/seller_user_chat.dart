import 'dart:developer';
import 'package:buildcondition/buildcondition.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/dashboard_layout/cubit/cubit.dart';
import '../../../layout/dashboard_layout/cubit/states.dart';
import '../../../models/orders/orders_model.dart';
import '../../../translations/locale_keys.g.dart';

class SellerUserChat extends StatefulWidget {
  const SellerUserChat(
      {Key key,
      this.orderModel,})
      : super(key: key);
  final OrdersModel orderModel;

  @override
  State<SellerUserChat> createState() => _SellerUserChatState();
}

class _SellerUserChatState extends State<SellerUserChat> {
  @override
  Future<void> didChangeDependencies() async {
    log(widget.orderModel.uid);
    await DashboardCubit.get(context)
        .getUid(widget.orderModel.uid);
    log(DashboardCubit.get(context).umodel.uId.toString());
    DashboardCubit.get(context)
        .getMessages(receiverId: widget.orderModel.uid);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    return SafeArea(
      child: BlocConsumer<DashboardCubit, DashboardStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  const CircleAvatar(
                    radius: 20.0,
                  ),
                  const SizedBox(
                    width: 7.0,
                  ),
                  Text(widget.orderModel.firstName),
                ],
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            ),
            body: BuildCondition(
                condition: DashboardCubit.get(context).messages.isNotEmpty,
                builder: (context) => Center(
                  child: Container(
                    width:
                    MediaQuery.of(context).size.width /
                        2,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(15.0),
                      border: Border.all(
                        width: 2.0,
                        color: Colors.black,
                      ),
                    ),
                    child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      var message = DashboardCubit.get(context)
                                          .messages[index];
                                      if (DashboardCubit.get(context)
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
                                    itemCount: DashboardCubit.get(context)
                                        .messages
                                        .length),
                              ),
                              const SizedBox(
                                height: 8.0,
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
                                          DashboardCubit.get(context).sendMessages(
                                              receiverId:
                                                  DashboardCubit.get(context)
                                                      .umodel
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
                                    style: const TextStyle(color: Colors.grey),
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
                                      DashboardCubit.get(context).sendMessages(
                                          receiverId:
                                              DashboardCubit.get(context)
                                                  .umodel
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
        },
      ),
    );
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
