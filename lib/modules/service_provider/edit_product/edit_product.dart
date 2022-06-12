import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/dashboard_layout/cubit/cubit.dart';
import '../../../layout/dashboard_layout/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../translations/locale_keys.g.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({
    Key key,
    this.pName,
    this.pDescription,
    this.pListImage,
    this.pCategory,
    this.pPrice,
    this.pDelivery,
    this.pIsS,
    this.pIsM,
    this.pIsL,
    this.pIsXL,
    this.pIs2XL,
    this.pIs3XL,
    this.pIs4XL,
    this.pIs5XL,
    this.pId,
    this.pDiscount,
  }) : super(key: key);
  final String pName;
  final num pPrice;
  final String pDelivery;
  final String pDescription;
  final String pCategory;
  final num pDiscount;
  final String pId;
  final List pListImage;
  final bool pIsS;
  final bool pIsM;
  final bool pIsL;
  final bool pIsXL;
  final bool pIs2XL;
  final bool pIs3XL;
  final bool pIs4XL;
  final bool pIs5XL;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var formKey = GlobalKey<FormState>();
  var caroController = CarouselController();
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  var deliveryController = TextEditingController();
  var discountController = TextEditingController();
  var firebaseLinks = [];

  @override
  void initState() {
    descriptionController.text = widget.pDescription;
    priceController.text = widget.pPrice.toString();
    deliveryController.text = widget.pDelivery;
    discountController.text = widget.pDiscount.toString();
    nameController.text = widget.pName;
    // isDescripted = true;

    DashboardCubit.get(context).createScreenDropDownValueEn = widget.pCategory;
    widget.pDelivery.isNotEmpty
        ? DashboardCubit.get(context).deliveryToggle = true
        : false;
    widget.pDiscount != 0
        ? DashboardCubit.get(context).discountToggle = true
        : false;
    DashboardCubit.get(context).isS = widget.pIsS;
    DashboardCubit.get(context).isM = widget.pIsM;
    DashboardCubit.get(context).isL = widget.pIsL;
    DashboardCubit.get(context).isXL = widget.pIsXL;
    DashboardCubit.get(context).is2XL = widget.pIs2XL;
    DashboardCubit.get(context).is3XL = widget.pIs3XL;
    DashboardCubit.get(context).is4XL = widget.pIs4XL;
    DashboardCubit.get(context).is5XL = widget.pIs5XL;
    DashboardCubit.get(context).listImage = [];
    log(widget.pId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_outlined)),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: MediaQuery.of(context).size.height / 100.0),
                      child: Form(
                        key: formKey,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(59),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 70.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                          color: Colors.black26, width: 2.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.category,
                                          color: Colors.grey,
                                        ),
                                        const Spacer(),
                                        Text(
                                          LocaleKeys
                                              .sellerCreateProductScreen_category
                                              .tr(),
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 16.0),
                                        ),
                                        const SizedBox(
                                          width: 80.0,
                                        ),
                                        DropdownButton(
                                          value: DashboardCubit.get(context)
                                              .createScreenDropDownValueEn,
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          items: DashboardCubit.get(context)
                                              .createProductItemsEn
                                              .map((String items) {
                                            return DropdownMenuItem(
                                              value: items,
                                              child: Text(items),
                                            );
                                          }).toList(),
                                          onChanged: (newValue) {
                                            DashboardCubit.get(context)
                                                .changeEditProductDropButtonValue(
                                                    newValue, context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                defaultFormField(
                                  type: TextInputType.name,
                                  prefix: Icons.text_fields_outlined,
                                  isValidate: true,
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return LocaleKeys
                                          .sellerCreateProductScreen_pleaseEnterProductName
                                          .tr();
                                    }
                                  },
                                  isPassword: false,
                                  controller: nameController,
                                  label: LocaleKeys
                                      .sellerRequestScreen_productName
                                      .tr(),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),

                                // defaultFormField(
                                //   type: TextInputType.multiline,
                                //   prefix: Icons.category,
                                //   validate: (value) {
                                //     if (value.isEmpty) {
                                //       return "Please enter Description";
                                //     }
                                //   },
                                //   isPassword: false,
                                //   controller: descriptionController,
                                //   label: "Description",
                                // ),
                                TextField(
                                  controller: descriptionController,
                                  keyboardType: TextInputType.text,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.black26,
                                          width: 2.5,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                        width: 2.5,
                                      ),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    labelText: LocaleKeys
                                        .sellerCreateProductScreen_description
                                        .tr(),
                                    prefixIcon: const Icon(Icons.text_fields),
                                  ),
                                ),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      LocaleKeys.sellerCreateProductScreen_size
                                              .tr() +
                                          ':',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20.0,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            child: buildSizeCircle(
                                                size: 'S',
                                                state:
                                                    DashboardCubit.get(context)
                                                        .isS),
                                            onTap: () {
                                              DashboardCubit.get(context)
                                                  .changeSize('isS');
                                            }),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        GestureDetector(
                                            child: buildSizeCircle(
                                                size: 'M',
                                                state:
                                                    DashboardCubit.get(context)
                                                        .isM),
                                            onTap: () {
                                              DashboardCubit.get(context)
                                                  .changeSize('isM');
                                            }),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        GestureDetector(
                                          child: buildSizeCircle(
                                              size: 'L',
                                              state: DashboardCubit.get(context)
                                                  .isL),
                                          onTap: () {
                                            DashboardCubit.get(context)
                                                .changeSize('isL');
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        GestureDetector(
                                          child: buildSizeCircle(
                                              size: 'XL',
                                              state: DashboardCubit.get(context)
                                                  .isXL),
                                          onTap: () {
                                            DashboardCubit.get(context)
                                                .changeSize('isXL');
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          child: buildSizeCircle(
                                              size: '2XL',
                                              state: DashboardCubit.get(context)
                                                  .is2XL),
                                          onTap: () {
                                            DashboardCubit.get(context)
                                                .changeSize('is2XL');
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        GestureDetector(
                                          child: buildSizeCircle(
                                              size: '3XL',
                                              state: DashboardCubit.get(context)
                                                  .is3XL),
                                          onTap: () {
                                            DashboardCubit.get(context)
                                                .changeSize('is3XL');
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        GestureDetector(
                                          child: buildSizeCircle(
                                              size: '4XL',
                                              state: DashboardCubit.get(context)
                                                  .is4XL),
                                          onTap: () {
                                            DashboardCubit.get(context)
                                                .changeSize('is4XL');
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        GestureDetector(
                                          child: buildSizeCircle(
                                              size: '5XL',
                                              state: DashboardCubit.get(context)
                                                  .is5XL),
                                          onTap: () {
                                            DashboardCubit.get(context)
                                                .changeSize('is5XL');
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      LocaleKeys
                                              .sellerCreateProductScreen_priceOffers
                                              .tr() +
                                          ':',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20.0,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: defaultFormField(
                                            type: TextInputType.number,
                                            prefix:
                                                Icons.confirmation_num_outlined,
                                            isValidate: true,
                                            validate: (value) {
                                              if (value.isEmpty) {
                                                return LocaleKeys
                                                    .sellerCreateProductScreen_PleaseEnterPrice
                                                    .tr();
                                              }
                                            },
                                            isPassword: false,
                                            controller: priceController,
                                            label: LocaleKeys
                                                .sellerCreateProductScreen_price
                                                .tr(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          LocaleKeys.sellerAcountScreen_discount
                                                  .tr() +
                                              ':',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15.0,
                                            color: Colors.black45,
                                          ),
                                        ),
                                        Switch(
                                            activeColor: Colors.black,
                                            activeTrackColor: Colors.black54,
                                            value: DashboardCubit.get(context)
                                                .discountToggle,
                                            onChanged: (v) {
                                              DashboardCubit.get(context)
                                                  .changeDiscountValue(v);
                                            }),
                                      ],
                                    ),
                                    defaultFormField(
                                      type: TextInputType.number,
                                      prefix: Icons.local_offer_outlined,
                                      isValidate: true,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          return LocaleKeys
                                              .sellerAcountScreen_pleaseEnterDiscount
                                              .tr();
                                        }
                                      },
                                      isClickable: DashboardCubit.get(context)
                                          .discountToggle,
                                      isPassword: false,
                                      controller: discountController,
                                      label: LocaleKeys
                                              .sellerAcountScreen_discount
                                              .tr() +
                                          '  %',
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          LocaleKeys
                                              .sellerCreateProductScreen_delivery
                                              .tr(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15.0,
                                            color: Colors.black45,
                                          ),
                                        ),
                                        Switch(
                                            activeColor: Colors.black,
                                            activeTrackColor: Colors.black54,
                                            value: DashboardCubit.get(context)
                                                .deliveryToggle,
                                            onChanged: (v) {
                                              DashboardCubit.get(context)
                                                  .changeDeliveryValue(v);
                                            }),
                                      ],
                                    ),
                                    defaultFormField(
                                      type: TextInputType.text,
                                      prefix: Icons.monetization_on_outlined,
                                      isValidate: true,
                                      validate: (value) {
                                        if (value.isEmpty) {
                                          if (DashboardCubit.get(context)
                                              .deliveryToggle) {
                                            return LocaleKeys.sellerCreateProductScreen_pleaseEnterDeliveryCost.tr();
                                          }
                                        }
                                      },
                                      isClickable: DashboardCubit.get(context)
                                          .deliveryToggle,
                                      isPassword: false,
                                      controller: deliveryController,
                                      label: LocaleKeys.sellerCreateProductScreen_delivery.tr(),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    ConditionalBuilder(
                                      condition:
                                          state is! UpdateProductLoadingState,
                                      builder: (context) => defaultButton(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        radius: 20.0,
                                        height: 50.0,
                                        text: LocaleKeys.sellerCreateProductScreen_submit.tr(),
                                        function: () async {
                                          if (formKey.currentState.validate() &&
                                              (DashboardCubit.get(context)
                                                          .createScreenDropDownValueEn ==
                                                      'None' ||
                                                  DashboardCubit.get(context)
                                                          .createScreenDropDownValueAr ==
                                                      'لا شيء')) {
                                            DashboardCubit.get(context)
                                                .updateProduct(
                                              id: widget.pId,
                                              isDiscount:
                                                  DashboardCubit.get(context)
                                                      .discountToggle,
                                              category: DashboardCubit.get(
                                                      context)
                                                  .createScreenDropDownValueEn,
                                              description:
                                                  descriptionController.text,
                                              name: nameController.text,
                                              price: int.parse(
                                                  priceController.text),
                                              oldPrice: 0,
                                              discount: double.parse(
                                                  discountController.text),
                                              pbid: DashboardCubit.get(context)
                                                  .createId(6),
                                              isS: DashboardCubit.get(context)
                                                  .isS,
                                              isM: DashboardCubit.get(context)
                                                  .isM,
                                              isL: DashboardCubit.get(context)
                                                  .isL,
                                              isXL: DashboardCubit.get(context)
                                                  .isXL,
                                              is2XL: DashboardCubit.get(context)
                                                  .is2XL,
                                              is3XL: DashboardCubit.get(context)
                                                  .is3XL,
                                              is4XL: DashboardCubit.get(context)
                                                  .is4XL,
                                              is5XL: DashboardCubit.get(context)
                                                  .is5XL,
                                              isShipping:
                                                  DashboardCubit.get(context)
                                                      .deliveryToggle,
                                              shippingPrice:
                                                  deliveryController.text,
                                              state: 'Pending',
                                            );
                                            DashboardCubit.get(context)
                                                .getAllProducts();
                                            DashboardCubit.get(context)
                                                .getAllOrdered(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          }
                                          // log(DashboardCubit.get(context)
                                          //     .listImage.toString());
                                          // log()
                                        },
                                        background: Colors.black,
                                      ),
                                      fallback: (context) => const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
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
}
