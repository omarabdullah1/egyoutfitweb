import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../translations/locale_keys.g.dart';
import '../home_selected_product/selected_prodct.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      ShopCubit.get(context).getAllProducts();
      ShopCubit.get(context).getFavourite();
      ShopCubit.get(context).getCart();
      ShopCubit.get(context).getOrders();
      ShopCubit.get(context).getPromoCodes();
      ShopCubit.get(context).getProducts('Men');
      ShopCubit.get(context).getProducts('Women');
      ShopCubit.get(context).getProducts('Children');
      ShopCubit.get(context).getProducts('Bags');
      ShopCubit.get(context).getProducts('Accessories');
      ShopCubit.get(context).getProducts('Shoe');
      ShopCubit.get(context).getProducts('Sports');
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).isEnglish = EasyLocalization.of(context).locale.languageCode == 'en'? true : false;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopLoginSuccessState) {
          log(state.loginModel.firstName);
        } else if (state is AddFavouritesSuccessState) {
          showToast(
              text: LocaleKeys.alerts_productAddedToYourFavourites.tr(),
              state: ToastStates.success);
        } else if (state is RemoveFavouritesSuccessState) {
          showToast(
              text: LocaleKeys.alerts_productRemovedFromYourFavourites.tr(),
              state: ToastStates.error);
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! FSuccessState &&
              ShopCubit.get(context).products != null &&
              ShopCubit.get(context).menCategory != null &&
              ShopCubit.get(context).womenCategory != null &&
              ShopCubit.get(context).childrenCategory != null &&
              ShopCubit.get(context).sportCategory != null &&
              ShopCubit.get(context).shoeCategory != null &&
              ShopCubit.get(context).bagCategory != null &&
              ShopCubit.get(context).accessoriesCategory != null &&
              ShopCubit.get(context).offers != null,
          builder: (context) => builderWidget(context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget builderWidget(context) {
    return RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 2), () {
            ShopCubit.get(context).getAllProducts();
            ShopCubit.get(context).getFavourite();
            ShopCubit.get(context).getCart();
            ShopCubit.get(context).getOrders();
            ShopCubit.get(context).getPromoCodes();
            ShopCubit.get(context).getProducts('Men');
            ShopCubit.get(context).getProducts('Women');
            ShopCubit.get(context).getProducts('Children');
            ShopCubit.get(context).getProducts('Bags');
            ShopCubit.get(context).getProducts('Accessories');
            ShopCubit.get(context).getProducts('Shoe');
            ShopCubit.get(context).getProducts('Sports');
          });
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    items: ShopCubit.get(context)
                        .offers
                        .map((e) => Image(
                              image: NetworkImage(e),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(seconds: 1),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 21,
                                    child: SizedBox(
                                      height: 45.0,
                                      child: categoryButton(
                                        text: LocaleKeys.usersHomeScreen_mens.tr(),
                                        iconPath: 'assets/images/mens.png',
                                        color: Colors.deepOrangeAccent,
                                        context: context,
                                        mmodel: ShopCubit.get(context).menCategory,
                                        mmodelID:
                                            ShopCubit.get(context).menCategoryID,
                                        name: EasyLocalization.of(context)
                                                    .locale
                                                    .languageCode ==
                                                'en'
                                            ? 'Men\'s'
                                            : 'أزياء رجالية',
                                        // width: 28.0,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    flex: 21,
                                    child: SizedBox(
                                      height: 45.0,
                                      child: categoryButton(
                                        text:
                                            LocaleKeys.usersHomeScreen_womens.tr(),
                                        iconPath: 'assets/images/women.png',
                                        color: Colors.pink,
                                        context: context,
                                        mmodel:
                                            ShopCubit.get(context).womenCategory,
                                        mmodelID:
                                            ShopCubit.get(context).womenCategoryID,

                                        name: EasyLocalization.of(context)
                                                    .locale
                                                    .languageCode ==
                                                'en'
                                            ? 'Women\'s'
                                            : 'الموضة النسائية',
                                        // width: 28.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 21,
                                    child: SizedBox(
                                      height: 45.0,
                                      child: categoryButton(
                                        text: LocaleKeys.usersHomeScreen_shoes.tr(),
                                        iconPath: 'assets/images/shoes.png',
                                        color: Colors.deepPurple,
                                        context: context,
                                        mmodel: ShopCubit.get(context).shoeCategory,
                                        mmodelID:
                                            ShopCubit.get(context).shoeCategoryID,
                                        name: EasyLocalization.of(context)
                                                    .locale
                                                    .languageCode ==
                                                'en'
                                            ? 'Shoes'
                                            : 'أحذية',
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    flex: 21,
                                    child: SizedBox(
                                      height: 45.0,
                                      child: categoryButton(
                                        text: LocaleKeys.usersHomeScreen_bags.tr(),
                                        iconPath: 'assets/images/bags.png',
                                        color: Colors.teal,
                                        context: context,
                                        mmodel: ShopCubit.get(context).bagCategory,
                                        mmodelID:
                                            ShopCubit.get(context).bagCategoryID,
                                        name: EasyLocalization.of(context)
                                                    .locale
                                                    .languageCode ==
                                                'en'
                                            ? 'Bags'
                                            : 'الحقائب',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 21,
                                    child: SizedBox(
                                      height: 45.0,
                                      child: categoryButton(
                                        color: Colors.green,
                                        text:
                                            LocaleKeys.usersHomeScreen_sports.tr(),
                                        iconPath: 'assets/images/sports.png',
                                        context: context,
                                        mmodel:
                                            ShopCubit.get(context).sportCategory,
                                        mmodelID:
                                            ShopCubit.get(context).sportCategoryID,
                                        name: EasyLocalization.of(context)
                                                    .locale
                                                    .languageCode ==
                                                'en'
                                            ? 'Sports'
                                            : 'الملابس الرياضية',
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Expanded(
                                    flex: 21,
                                    child: SizedBox(
                                      height: 45.0,
                                      child: categoryButton(
                                        text: LocaleKeys.usersHomeScreen_children
                                            .tr(),
                                        iconPath: 'assets/images/children.png',
                                        color: Colors.lightBlue,
                                        context: context,
                                        mmodel:
                                            ShopCubit.get(context).childrenCategory,
                                        mmodelID: ShopCubit.get(context)
                                            .childrenCategoryID,
                                        name: EasyLocalization.of(context)
                                                    .locale
                                                    .languageCode ==
                                                'en'
                                            ? 'Children'
                                            : 'ملابس أطفال',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 21,
                                    child: SizedBox(
                                      height: 45.0,
                                      child: categoryButton(
                                        text: LocaleKeys.usersHomeScreen_accessories
                                            .tr(),
                                        iconPath: 'assets/images/Accessories.png',
                                        color: Colors.red[900],
                                        context: context,
                                        mmodel: ShopCubit.get(context)
                                            .accessoriesCategory,
                                        mmodelID: ShopCubit.get(context)
                                            .accessoriesCategoryID,
                                        name: EasyLocalization.of(context)
                                                    .locale
                                                    .languageCode ==
                                                'en'
                                            ? 'Accessories'
                                            : 'اكسسوارات',
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Expanded(
                                    flex: 21,
                                    child: SizedBox(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          LocaleKeys.usersHomeScreen_recomendedForYou.tr(),
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      LocaleKeys.usersHomeScreen_mens.tr() + ':',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                    height: 300.0,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          navigateTo(
                            context,
                            HomeSelectedProductScreen(
                              productIndex: index,
                              mmodel: ShopCubit.get(context).menCategory[index],
                              mmodelID: ShopCubit.get(context).menCategoryID,
                              category: 'Men\'s',
                              color: Colors.deepOrangeAccent,
                            ),
                          );
                          // print(ShopCubit.get(context).menCategoryID);
                        },
                        child: buildRecommendedItem(
                          context: context,
                          index: index,
                          model: ShopCubit.get(context).menCategory,
                          idList: ShopCubit.get(context).menCategoryID,
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemCount: ShopCubit.get(context).menCategory.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      LocaleKeys.usersHomeScreen_womens.tr() + ':',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 300.0,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          navigateTo(
                              context,
                              HomeSelectedProductScreen(
                                productIndex: index,
                                mmodel: ShopCubit.get(context).womenCategory[index],
                                mmodelID: ShopCubit.get(context).womenCategoryID,
                                category: 'Women\'s',
                                color: Colors.pink,
                              ));
                        },
                        child: buildRecommendedItem(
                          context: context,
                          index: index,
                          model: ShopCubit.get(context).womenCategory,
                          idList: ShopCubit.get(context).womenCategoryID,
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemCount: ShopCubit.get(context).womenCategory.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      LocaleKeys.usersHomeScreen_shoes.tr() + ':',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 300.0,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          navigateTo(
                              context,
                              HomeSelectedProductScreen(
                                productIndex: index,
                                mmodel: ShopCubit.get(context).shoeCategory[index],
                                mmodelID: ShopCubit.get(context).shoeCategoryID,
                                category: 'Shoes',
                                color: Colors.deepPurple,
                              ));
                        },
                        child: buildRecommendedItem(
                          context: context,
                          index: index,
                          model: ShopCubit.get(context).shoeCategory,
                          idList: ShopCubit.get(context).shoeCategoryID,
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemCount: ShopCubit.get(context).shoeCategory.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      LocaleKeys.usersHomeScreen_bags.tr() + ':',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 300.0,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          navigateTo(
                              context,
                              HomeSelectedProductScreen(
                                productIndex: index,
                                mmodel: ShopCubit.get(context).bagCategory[index],
                                mmodelID: ShopCubit.get(context).bagCategoryID,
                                category: 'Bags',
                                color: Colors.teal,
                              ));
                        },
                        child: buildRecommendedItem(
                          context: context,
                          index: index,
                          model: ShopCubit.get(context).bagCategory,
                          idList: ShopCubit.get(context).bagCategoryID,
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemCount: ShopCubit.get(context).bagCategory.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      LocaleKeys.usersHomeScreen_sports.tr() + ':',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 300.0,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          navigateTo(
                              context,
                              HomeSelectedProductScreen(
                                productIndex: index,
                                mmodel: ShopCubit.get(context).sportCategory[index],
                                mmodelID: ShopCubit.get(context).sportCategoryID,
                                category: 'Sporting',
                                color: Colors.green,
                              ));
                        },
                        child: buildRecommendedItem(
                          context: context,
                          index: index,
                          model: ShopCubit.get(context).sportCategory,
                          idList: ShopCubit.get(context).sportCategoryID,
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemCount: ShopCubit.get(context).sportCategory.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      LocaleKeys.usersHomeScreen_children.tr() + ':',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 300.0,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          navigateTo(
                              context,
                              HomeSelectedProductScreen(
                                productIndex: index,
                                mmodel:
                                    ShopCubit.get(context).childrenCategory[index],
                                mmodelID: ShopCubit.get(context).childrenCategoryID,
                                category: 'Children',
                                color: Colors.lightBlue,
                              ));
                        },
                        child: buildRecommendedItem(
                          context: context,
                          index: index,
                          model: ShopCubit.get(context).childrenCategory,
                          idList: ShopCubit.get(context).childrenCategoryID,
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemCount: ShopCubit.get(context).childrenCategory.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      LocaleKeys.usersHomeScreen_accessories.tr() + ':',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 300.0,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          navigateTo(
                              context,
                              HomeSelectedProductScreen(
                                productIndex: index,
                                mmodel: ShopCubit.get(context)
                                    .accessoriesCategory[index],
                                mmodelID:
                                    ShopCubit.get(context).accessoriesCategoryID,
                                category: 'Accessories',
                                color: Colors.red,
                              ));
                        },
                        child: buildRecommendedItem(
                          context: context,
                          index: index,
                          model: ShopCubit.get(context).accessoriesCategory,
                          idList: ShopCubit.get(context).accessoriesCategoryID,
                        ),
                      ),
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemCount: ShopCubit.get(context).accessoriesCategory.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
