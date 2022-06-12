import 'package:easy_localization/easy_localization.dart';
import 'package:egyoutfitweb/modules/user/profile/user_order_screen_opened.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../translations/locale_keys.g.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ShopCubit.get(context).getOrders();
        return BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                  body: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(LocaleKeys.userAccountScreen_orders.tr(),style: Theme.of(context).textTheme.headline4,),
                                ],
                              ),
                            ),
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  await ShopCubit.get(context).getOrders();
                                },
                                child: ListView.separated(
                                  itemBuilder: (context, index) =>
                                      InkWell(
                                        onTap: () {
                                          navigateTo(
                                              context,
                                              UserOpenedOrderScreen(
                                                index: index,
                                                orderModel:
                                                ShopCubit
                                                    .get(context)
                                                    .ordersModel[index],
                                              ));
                                        },
                                        child: SizedBox(
                                            height: 180.0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border:
                                                Border.all(color: Colors.black, width: 2.0),
                                                borderRadius: BorderRadius.circular(14.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Image(
                                                      image: NetworkImage(
                                                        ShopCubit
                                                            .get(context)
                                                            .ordersModel[index]
                                                            .orderImage,
                                                      ),
                                                      width: MediaQuery.of(context).size.width / 4,
                                                    ),
                                                    const SizedBox(
                                                      width: 15.0,
                                                    ),
                                                    Container(
                                                      width: 1.5,
                                                      height: 100.0,
                                                      color: Colors.black,
                                                    ),
                                                    const SizedBox(
                                                      width: 15.0,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          Text(
                                                            LocaleKeys
                                                                .userAccountScreen_orderName
                                                                .tr() + ':  ' +
                                                                ShopCubit
                                                                    .get(context)
                                                                    .ordersModel[index]
                                                                    .orderName,
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                          const SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          Text(
                                                            LocaleKeys
                                                                .userAccountScreen_orderCost
                                                                .tr() + ':  ' +
                                                                ShopCubit
                                                                    .get(context)
                                                                    .ordersModel[index]
                                                                    .orderCost
                                                                    .toString(),
                                                          ),
                                                          const SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          Text(
                                                            LocaleKeys
                                                                .userAccountScreen_orderCount
                                                                .tr() + ':  ' +
                                                                ShopCubit
                                                                    .get(context)
                                                                    .ordersModel[index]
                                                                    .orderedProductsCount
                                                                    .toString(),
                                                          ),
                                                          const SizedBox(
                                                            height: 5.0,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                LocaleKeys
                                                                    .userAccountScreen_orderSize
                                                                    .tr() + ':  ' +
                                                                    (ShopCubit
                                                                        .get(context)
                                                                        .ordersModel[index]
                                                                        .orderSize == ''
                                                                        ? 'No'
                                                                        : ShopCubit
                                                                        .get(context)
                                                                        .ordersModel[index]
                                                                        .orderSize),
                                                              ),
                                                              const Spacer(),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                  left: 8.0,
                                                                  right: 8.0,
                                                                ),
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                    color: ShopCubit
                                                                        .get(
                                                                        context)
                                                                        .ordersModel[
                                                                    index]
                                                                        .pState ==
                                                                        'Pending'
                                                                        ? Colors.orange
                                                                        : ShopCubit
                                                                        .get(context)
                                                                        .ordersModel[
                                                                    index]
                                                                        .pState ==
                                                                        'Scheduled'
                                                                        ? Colors.blue
                                                                        : ShopCubit
                                                                        .get(context)
                                                                        .ordersModel[
                                                                    index]
                                                                        .pState ==
                                                                        'Cancelled'
                                                                        ? Colors.red
                                                                        : ShopCubit
                                                                        .get(context)
                                                                        .ordersModel[
                                                                    index]
                                                                        .pState ==
                                                                        'Completed'
                                                                        ? Colors
                                                                        .green
                                                                        : Colors
                                                                        .orange,
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                      14.0,
                                                                    ),
                                                                  ),
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets.only(
                                                                        left: 8.0,
                                                                        right: 8.0,
                                                                        top: 4.0,
                                                                        bottom: 4.0),
                                                                    child: Center(
                                                                      child: Text(
                                                                        ShopCubit
                                                                            .get(context)
                                                                            .ordersModel[index]
                                                                            .pState,
                                                                        style: const TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                        ),
                                                                      ),
                                                                    ),
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
                                            )),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: myDivider(),
                                      ),
                                  itemCount: ShopCubit
                                      .get(context)
                                      .ordersModel
                                      .length,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
        );
      }
    );
  }
}
