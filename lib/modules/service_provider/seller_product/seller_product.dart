import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/dashboard_layout/cubit/cubit.dart';
import '../../../layout/dashboard_layout/cubit/states.dart';
import '../../../models/shop_app/products_model.dart';
import '../../../shared/components/components.dart';
import '../../../translations/locale_keys.g.dart';
import '../edit_product/edit_product_image.dart';

class SellerProduct extends StatelessWidget {
  const SellerProduct({Key key, this.models, this.index, this.modelId})
      : super(key: key);
  final ShopProductsModel models;
  final int index;
  final String modelId;

  @override
  Widget build(BuildContext context) {
    var descriptionController = TextEditingController();
    var priceController = TextEditingController();
    var oldPriceController = TextEditingController();
    var discountController = TextEditingController();
    var nameController = TextEditingController();

    descriptionController.text = models.description;
    nameController.text = models.name;
    priceController.text = models.price.toString();
    oldPriceController.text = models.oldPrice.toString();
    discountController.text = models.discount.toString();
    log(modelId.toString());

    return SafeArea(
      child: BlocConsumer<DashboardCubit, DashboardStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_outlined)),
              actions: [
                IconButton(
                    onPressed: () {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.WARNING,
                          animType: AnimType.BOTTOMSLIDE,
                          title: LocaleKeys.alerts_warning.tr(),
                          desc: LocaleKeys.alerts_yourProductWillBeDeleted.tr(),
                          btnOkOnPress: () {
                            DashboardCubit.get(context).removeProduct(
                                DashboardCubit.get(context).productsID[index]);
                            DashboardCubit.get(context).getAllProducts();
                            DashboardCubit.get(context).getAllOrdered(context);
                            Navigator.pop(context);
                            // Navigator.of(context).pop();
                          },
                          btnCancelText: LocaleKeys.alerts_cancel.tr(),
                          btnOkText: LocaleKeys.alerts_ok.tr(),
                          btnCancelOnPress: () {
                            Navigator.pop(context);
                          }).show();
                    },
                    icon: const Icon(Icons.delete)),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                              DashboardCubit.get(context)
                                  .productDropDownValueColor,
                              radius: 5.0,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(15.0),
                                shape: BoxShape.rectangle,
                              ),
                              child: DropdownButton(
                                value: DashboardCubit.get(context)
                                    .productDropDownValueEn,
                                icon: const Icon(
                                    Icons.keyboard_arrow_down),
                                items: DashboardCubit.get(context)
                                    .productProductItemsEn
                                    .map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (newValue) async {
                                  DashboardCubit.get(context)
                                      .changeProductDropButtonValue(
                                    newValue,
                                    context,
                                  );
                                  DashboardCubit.get(context)
                                      .changeProductColor(
                                    newValue,
                                  );
                                  DashboardCubit.get(context)
                                      .changeProductState(
                                    true,
                                  );
                                  await DashboardCubit.get(context).changeOrderProductState(
                                    newValue,
                                    modelId,
                                    context,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width - 20.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(width: 2.0, color: Colors.black)),
                      child: Stack(
                        children: [
                          CarouselSlider(
                            items: models.image.isEmpty
                                ? const [Icon(Icons.image)]
                                : models.image
                                    .map((e) => Image.network(e))
                                    .toList(),
                            options: CarouselOptions(
                              onPageChanged: (index, reason) {
                                DashboardCubit.get(context)
                                    .changeProductCarousel(index);
                              },
                              aspectRatio: 1.0,
                              height: 240,
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: false,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(seconds: 1),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              scrollDirection: Axis.horizontal,
                            ),
                            // carouselController: caroController,
                          ),
                          Positioned(
                              bottom: 0.0,
                              right: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: FloatingActionButton(
                                      heroTag: 'uniqueTa',
                                      onPressed: () {
                                        navigateTo(
                                            context,
                                            EditProductImageScreen(
                                              pId: modelId,
                                              pListImage: models.image,
                                            ));
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        size: 20.0,
                                      ),
                                    )),
                              )),
                        ],
                      ),
                    ),
                    DotsIndicator(
                      dotsCount: models.image.length,
                      position: DashboardCubit.get(context)
                          .productCaroIndex
                          .toDouble(),
                      decorator: DotsDecorator(
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 8.0, left: 8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 30.0,
                            width: 80.0,
                            child: Text(
                              models.name,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 120.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Center(
                              child: Text(
                                models.category,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 8.0, left: 8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 30.0,
                            child: Text(
                              'Price: ${models.price} LE',
                              // overflow: TextOverflow.ellipsis,
                              // maxLines: 1,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                              height: 30.0,
                              child: Center(
                                  child:
                                      Text('Discount: % ${models.discount}')))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 8.0, left: 8.0),
                      child: Row(
                        children: [
                          const Text('Old Price:  '),
                          Text(models.oldPrice.toString() + ' LE'),
                        ],
                      ),
                    ),
                    models.isShipping
                        ? Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, right: 8.0, left: 8.0),
                            child: Row(
                              children: [
                                const Text('Delivery:  '),
                                Text(models.shippingPrice + ' LE'),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 8.0, left: 8.0),
                      child: Row(
                        children: [
                          Text(
                            models.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, right: 8.0, left: 8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (models.isS)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildSizeCircle(
                                      size: 'S', state: models.isS),
                                ),
                              if (models.isM)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildSizeCircle(
                                      size: 'M', state: models.isM),
                                ),
                              if (models.isL)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildSizeCircle(
                                      size: 'L', state: models.isL),
                                ),
                              if (models.isXL)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildSizeCircle(
                                      size: 'XL', state: models.isXL),
                                )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (models.is2XL)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildSizeCircle(
                                      size: '2XL', state: models.is2XL),
                                ),
                              if (models.is3XL)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildSizeCircle(
                                      size: '3XL', state: models.is3XL),
                                ),
                              if (models.is4XL)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildSizeCircle(
                                      size: '4XL', state: models.is4XL),
                                ),
                              if (models.is5XL)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: buildSizeCircle(
                                      size: '5XL', state: models.is5XL),
                                )
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
        },
      ),
    );
  }
}
