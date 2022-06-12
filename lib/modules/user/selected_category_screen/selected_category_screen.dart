import 'dart:developer';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/shop_app/products_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/icons.dart';
import '../../../translations/locale_keys.g.dart';

class SelectedCategoryScreen extends StatefulWidget {
  const SelectedCategoryScreen(
      {Key key, this.mmodel, this.nameOfCategory, this.mmodelID})
      : super(key: key);
  final List<ShopProductsModel> mmodel;
  final List mmodelID;
  final String nameOfCategory;

  @override
  State<SelectedCategoryScreen> createState() => _SelectedCategoryScreenState();
}

class _SelectedCategoryScreenState extends State<SelectedCategoryScreen> {
  var itemsEn = [
    'Men\'s',
    'Women\'s',
    'Shoes',
    'Bags',
    'Children',
    'Sports',
    'Accessories',
  ];
  var itemsAr = [
    'أزياء رجالية',
    'الموضة النسائية',
    'أحذية',
    'الحقائب',
    'ملابس أطفال',
    'الملابس الرياضية',
    'اكسسوارات',
  ];

  @override
  Widget build(BuildContext context) {
    var widthQuarter = MediaQuery.of(context).size.width / 4;
    var width = MediaQuery.of(context).size.width;
    ShopCubit.get(context).changeDropValue(widget.nameOfCategory, context);
    List<ShopProductsModel> _mmodel = widget.mmodel;
    List _mmodelID = widget.mmodelID;
    String _nameOfCategory = widget.nameOfCategory;
    // Initial Selected Value
    log(EasyLocalization.of(context).locale.languageCode);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).menCategory != null &&
              ShopCubit.get(context).womenCategory != null &&
              ShopCubit.get(context).sportCategory != null &&
              ShopCubit.get(context).shoeCategory != null &&
              ShopCubit.get(context).childrenCategory != null &&
              ShopCubit.get(context).accessoriesCategory != null &&
              ShopCubit.get(context).bagCategory != null,
          builder: (context) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  // size: 14.0,
                  color: Colors.black,
                ),
              ),
              actions: [
                SizedBox(
                  child: GestureDetector(
                    onTap: () {
                      // navigateTo(context, const SearchScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                        right: 10.0,
                      ),
                      child: Container(
                        width: width - widthQuarter,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            Text(
                              LocaleKeys.usersHomeScreen_searchInEgyOutfit.tr(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    MyCartIcon.myCart,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          _nameOfCategory,
                          style: const TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        SizedBox(
                          child: DropdownButton(
                            value: EasyLocalization.of(context)
                                        .locale
                                        .languageCode ==
                                    'en'
                                ? ShopCubit.get(context).dropdownvalueEn
                                : ShopCubit.get(context).dropdownvalueAr,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: EasyLocalization.of(context)
                                        .locale
                                        .languageCode ==
                                    'en'
                                ? itemsEn.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList()
                                : itemsAr.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                            onChanged: (newValue) {
                              ShopCubit.get(context)
                                  .changeDropButtonValue(newValue,context);
                              if (newValue == 'Men\'s' ||
                                  newValue == 'أزياء رجالية') {
                                _mmodel = ShopCubit.get(context).menCategory;
                                _mmodelID =
                                    ShopCubit.get(context).menCategoryID;
                                _nameOfCategory = newValue;
                              } else if (newValue == 'Women\'s' ||
                                  newValue == 'الموضة النسائية') {
                                _mmodel = ShopCubit.get(context).womenCategory;
                                _mmodelID =
                                    ShopCubit.get(context).womenCategoryID;
                                _nameOfCategory = newValue;
                              } else if (newValue == 'Shoes' ||
                                  newValue == 'أحذية') {
                                _mmodel = ShopCubit.get(context).shoeCategory;
                                _mmodelID =
                                    ShopCubit.get(context).shoeCategoryID;
                                _nameOfCategory = newValue;
                              } else if (newValue == 'Bags' ||
                                  newValue == 'الحقائب') {
                                _mmodel = ShopCubit.get(context).bagCategory;
                                _mmodelID =
                                    ShopCubit.get(context).bagCategoryID;
                                _nameOfCategory = newValue;
                              } else if (newValue == 'Children' ||
                                  newValue == 'ملابس أطفال') {
                                _mmodel =
                                    ShopCubit.get(context).childrenCategory;
                                _mmodelID =
                                    ShopCubit.get(context).childrenCategoryID;
                                _nameOfCategory = newValue;
                              } else if (newValue == 'Sports' ||
                                  newValue == 'الملابس الرياضية') {
                                _mmodel = ShopCubit.get(context).sportCategory;
                                _mmodelID =
                                    ShopCubit.get(context).sportCategoryID;
                                _nameOfCategory = newValue;
                              } else if (newValue == 'Accessories' ||
                                  newValue == 'اكسسوارات') {
                                _mmodel =
                                    ShopCubit.get(context).accessoriesCategory;
                                _mmodelID = ShopCubit.get(context)
                                    .accessoriesCategoryID;
                                _nameOfCategory = newValue;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    childAspectRatio: 1 / 1.58,
                    children: List.generate(
                      // widget.mmodel.data.data.length,
                      _mmodel.length,
                      (index) => buildGridProduct(
                        model: _mmodel,
                        index: index,
                        context: context,
                        idList: _mmodelID,
                        category: _nameOfCategory,
                        color: _nameOfCategory == 'Men\'s'
                            ? Colors.deepOrange
                            : _nameOfCategory == 'Women\'s'
                                ? Colors.pink
                                : _nameOfCategory == 'Shoes'
                                    ? Colors.deepPurple
                                    : _nameOfCategory == 'Bags'
                                        ? Colors.teal
                                        : _nameOfCategory == 'Sports'
                                            ? Colors.green
                                            : _nameOfCategory == 'Children'
                                                ? Colors.lightBlue
                                                : _nameOfCategory ==
                                                        'Accessories'
                                                    ? Colors.red
                                                    : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class OpenImage extends StatelessWidget {
  final String mImage;

  const OpenImage({Key key, this.mImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image(
          image: NetworkImage(
            mImage,
          ),
          // width: 500,
          width: double.infinity,
        ),
      ),
    );
  }
}
