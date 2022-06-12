import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../../translations/locale_keys.g.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLayout extends StatefulWidget {
  const ShopLayout({Key key}) : super(key: key);

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  @override
  Future<void> didChangeDependencies() async {
    ShopCubit.get(context).sState();
    await ShopCubit.get(context).getData(context);
    Future.delayed(const Duration(seconds: 2), () async {
      await ShopCubit.get(context).getAllProducts();
      await ShopCubit.get(context).getFavourite();
      await ShopCubit.get(context).getCart();
      await ShopCubit.get(context).getOrders();
      await ShopCubit.get(context).getPromoCodes();
      await ShopCubit.get(context).getProducts('Men');
      await ShopCubit.get(context).getProducts('Women');
      await ShopCubit.get(context).getProducts('Children');
      await ShopCubit.get(context).getProducts('Bags');
      await ShopCubit.get(context).getProducts('Accessories');
      await ShopCubit.get(context).getProducts('Shoe');
      await ShopCubit.get(context).getProducts('Sports');
      await ShopCubit.get(context).fState();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var widthQuarter = MediaQuery.of(context).size.width / 3;
    var width = MediaQuery.of(context).size.width;
    ShopCubit.get(context).isEnglish =
        EasyLocalization.of(context).locale.languageCode == 'en' ? true : false;

    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              // backgroundColor: Colors.black,
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/Egy-Outfit-Black.png',
                    height: 50.0,
                  ),
                ],
              ),
              actions: [
                SizedBox(
                  child: GestureDetector(
                    onTap: () {
                      // navigateTo(context, const SearchScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 10.0, right: 10.0),
                      child: Container(
                        width: width - widthQuarter,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            Text(
                              LocaleKeys.usersHomeScreen_searchInEgyOutfit.tr(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        builder: (context) =>
                            BlocConsumer<ShopCubit, ShopStates>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return AlertDialog(
                              actions: [
                                Row(
                                  children: [
                                    defaultButton(
                                      function: () {
                                        ShopCubit.get(context)
                                                .userRegisterDropdownHomeValueEn =
                                            ShopCubit.get(context)
                                                .loginModel
                                                .city;
                                        ShopCubit.get(context)
                                                .userRegisterDropdownHomeValueAr =
                                            ShopCubit.get(context).itemsAr[
                                                ShopCubit.get(context)
                                                    .itemsEn
                                                    .indexOf(
                                                        ShopCubit.get(context)
                                                            .loginModel
                                                            .city)];
                                        Navigator.pop(context);
                                      },
                                      text: LocaleKeys.alerts_cancel.tr(),
                                      background: Colors.red,
                                      height: 50.0,
                                      width: 100.0,
                                      radius: 14.0,
                                    ),
                                    const Spacer(),
                                    defaultButton(
                                      function: () {
                                        EasyLocalization.of(context)
                                                    .locale
                                                    .languageCode ==
                                                'en'
                                            ? ShopCubit.get(context)
                                                    .userRegisterDropdownHomeValue =
                                                ShopCubit.get(context)
                                                    .userRegisterDropdownHomeValueEn
                                            : ShopCubit.get(context)
                                                    .userRegisterDropdownHomeValue =
                                                ShopCubit.get(context).itemsEn[
                                                    ShopCubit.get(context)
                                                        .itemsAr
                                                        .indexOf(
                                                            ShopCubit.get(context)
                                                                .userRegisterDropdownHomeValueAr)];
                                        ShopCubit.get(context).getAllProducts();
                                        ShopCubit.get(context).getFavourite();
                                        ShopCubit.get(context).getCart();
                                        ShopCubit.get(context).getOrders();
                                        ShopCubit.get(context).getPromoCodes();
                                        ShopCubit.get(context)
                                            .getProducts('Men');
                                        ShopCubit.get(context)
                                            .getProducts('Women');
                                        ShopCubit.get(context)
                                            .getProducts('Children');
                                        ShopCubit.get(context)
                                            .getProducts('Bags');
                                        ShopCubit.get(context)
                                            .getProducts('Accessories');
                                        ShopCubit.get(context)
                                            .getProducts('Shoe');
                                        ShopCubit.get(context)
                                            .getProducts('Sports');

                                        Navigator.pop(context);
                                      },
                                      text: LocaleKeys.alerts_ok.tr(),
                                      background: Colors.green,
                                      height: 50.0,
                                      width: 100.0,
                                      radius: 14.0,
                                    ),
                                  ],
                                ),
                              ],
                              content: SizedBox(
                                width: double.infinity,
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
                                            LocaleKeys.signUpScreen_select_City
                                                .tr(),
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
                                        ? ShopCubit.get(context)
                                            .itemsEn
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList()
                                        : ShopCubit.get(context)
                                            .itemsAr
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ))
                                            .toList(),
                                    value: EasyLocalization.of(context)
                                                .locale
                                                .languageCode ==
                                            'en'
                                        ? ShopCubit.get(context)
                                            .userRegisterDropdownHomeValueEn
                                        : ShopCubit.get(context)
                                            .userRegisterDropdownHomeValueAr,
                                    onChanged: (value) {
                                      ShopCubit.get(context)
                                          .userChangeDropHomeValue(
                                              value, context);
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
                                    buttonPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        width: 2.5,
                                        color: Colors.black26,
                                      ),
                                      color: Colors.white,
                                    ),
                                    itemHeight: 40,
                                    itemPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
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
                            );
                          },
                        ),
                        context: context,
                      );
                    },
                    icon: const Icon(
                      Icons.sort,
                      color: Colors.black,
                    )),
              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/Egy-Outfit-Black.png',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cubit.currentIndex=0;
                      cubit.counterChange();
                    },
                    child: const ListTile(
                      title: Text(
                        'Home',
                      ),
                      leading: Icon(Icons.home_filled),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cubit.currentIndex=1;
                      cubit.counterChange();
                    },
                    child: const ListTile(
                      title: Text(
                        'Cart',
                      ),
                      leading: Icon(Icons.shopping_cart),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cubit.currentIndex=2;
                      cubit.counterChange();
                    },
                    child: const ListTile(
                      title: Text(
                        'Offers',
                      ),
                      leading: Icon(Icons.local_offer),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cubit.currentIndex=3;
                      cubit.counterChange();
                    },
                    child: const ListTile(
                      title: Text(
                        'Favourites',
                      ),
                      leading: Icon(Icons.favorite),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cubit.currentIndex=4;
                      cubit.counterChange();
                    },
                    child: const ListTile(
                      title: Text(
                        'Profile',
                      ),
                      leading: Icon(Icons.person),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
