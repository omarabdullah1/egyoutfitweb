import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../translations/locale_keys.g.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartState();
}

class _CartState extends State<CartScreen> {
  Timer _timer;

  @override
  void initState() {
    ShopCubit.get(context).cartPriceList = [];
    ShopCubit.get(context).counters = [];
    ShopCubit.get(context).getCart();

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      ShopCubit.get(context).cartPriceList = [];
      // log(ShopCubit.get(context).counters.toString());
      ShopCubit.get(context).getCartPrice(ShopCubit.get(context).cartModel);
      // log(ShopCubit.get(context).cartPriceList.toString());
      // log(ShopCubit.get(context).cartPrice.toString());
      ShopCubit.get(context).changeCartPrice();
    });

    // log(ShopCubit.get(context).counters.toString());
    // ShopCubit.get(context).cartPriceList.clear();
    // ShopCubit.get(context).cartPrice = 0;
    // for (var element in ShopCubit.get(context).cartModel) {
    //   ShopCubit.get(context).cartPriceList.add(element.price *
    //       ShopCubit.get(context)
    //           .counters[ShopCubit.get(context).cartModel.indexOf(element)]);
    // }
    // for (var element in ShopCubit.get(context).cartPriceList) {
    //   ShopCubit.get(context).cartPrice += element;
    // }
    // log(ShopCubit.get(context).cartPriceList.toString());
    // log(ShopCubit.get(context).cartPrice.toString());
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // if(state is ChangeCounterState){
        //   // ShopCubit.get(context).getCartPrice(ShopCubit.get(context).cartModel);
        //   // log('${ShopCubit.get(context).counters}');
        //   // log(ShopCubit.get(context).counters.toString());
        //
        // }
      },
      builder: (context, state) {
        return ShopCubit.get(context).cart.isEmpty
            ? Center(
                child: Text(LocaleKeys.userCartScreen_emptyCartMessage.tr()),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                     SizedBox(
                       width: MediaQuery.of(context).size.width / 2,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Text(LocaleKeys.alerts_yourItems.tr(),style: Theme.of(context).textTheme.headline4,),
                         ],
                       ),
                     ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height-270.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => BuildListProduct2(
                            context: context,
                            model: ShopCubit.get(context).cartModel[index],
                            idList: ShopCubit.get(context).cart[index],
                            index: index,
                            sizee: ShopCubit.get(context).size[index],
                            flag: ShopCubit.get(context).cartScreenFlag,
                          ),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: ShopCubit.get(context).cartModel.length,
                        ),
                      ),
                    ),
                    /*const SizedBox(
                      height: 15.0,
                    ),*/
                    Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: Center(
                            child: Text(LocaleKeys.userCartScreen_totalPrice
                                    .tr() +
                                ':' +
                                ShopCubit.get(context).cartPrice.toString() +
                                '\$'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
      },
    );
  }
}
