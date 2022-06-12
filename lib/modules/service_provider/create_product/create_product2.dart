import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/dashboard_layout/cubit/cubit.dart';
import '../../../layout/dashboard_layout/cubit/states.dart';
import '../../../layout/dashboard_layout/dashboard_layout.dart';
import '../../../shared/components/components.dart';
import '../../../translations/locale_keys.g.dart';

class CreateProductScreen2 extends StatelessWidget {
  const CreateProductScreen2(
      {Key key, this.images, this.category, this.name, this.description})
      : super(key: key);
  final List images;
  final String category;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var priceController = TextEditingController();
    var costController = TextEditingController();
    var discountController = TextEditingController();
    DashboardCubit.get(context).isS = false;
    DashboardCubit.get(context).isS = false;
    DashboardCubit.get(context).isM = false;
    DashboardCubit.get(context).isL = false;
    DashboardCubit.get(context).isXL = false;
    DashboardCubit.get(context).is2XL = false;
    DashboardCubit.get(context).is3XL = false;
    DashboardCubit.get(context).is4XL = false;
    DashboardCubit.get(context).is5XL = false;
    DashboardCubit.get(context).createScreenDropDownValueEn = 'None';
    DashboardCubit.get(context).discountToggle = false;
    DashboardCubit.get(context).deliveryToggle = false;

    return BlocConsumer<DashboardCubit, DashboardStates>(
      listener: (context, state) {
        if (state is CreateProductSuccessState) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.BOTTOMSLIDE,
            title: LocaleKeys.sellerCreateProductScreen_success.tr(),
            desc: LocaleKeys
                .sellerCreateProductScreen_yourProductHasBeenSubmitted
                .tr(),
            btnOkOnPress: () {
              navigateAndFinish(context, const DashboardLayout());
              // Navigator.of(context).pop();
            },
          ).show();
        }
      },
      builder: (context, state) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 36),
                    child: Form(
                      key: formKey,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              !(category == 'Shoe' ||
                                      category == 'Bags' ||
                                      category == 'Accessories')
                                  ? const SizedBox(
                                      height: 30,
                                    )
                                  : const SizedBox(),
                              !(category == 'Shoe' ||
                                      category == 'Bags' ||
                                      category == 'Accessories')
                                  ? Text(
                                      LocaleKeys.sellerCreateProductScreen_size
                                              .tr() +
                                          ':  ',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20.0,
                                          color: Colors.black45),
                                    )
                                  : const SizedBox(),
                              !(category == 'Shoe' ||
                                      category == 'Bags' ||
                                      category == 'Accessories')
                                  ? Row(
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
                                    )
                                  : const SizedBox(),
                              !(category == 'Shoe' ||
                                      category == 'Bags' ||
                                      category == 'Accessories')
                                  ? const SizedBox(
                                      height: 15.0,
                                    )
                                  : const SizedBox(),
                              !(category == 'Shoe' ||
                                      category == 'Bags' ||
                                      category == 'Accessories')
                                  ? Row(
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
                                    )
                                  : const SizedBox(),
                              !(category == 'Shoe' ||
                                      category == 'Bags' ||
                                      category == 'Accessories')
                                  ? const SizedBox(
                                      height: 15,
                                    )
                                  : const SizedBox(),
                              Text(
                                LocaleKeys.sellerCreateProductScreen_priceOffers
                                    .tr(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20.0,
                                    color: Colors.black45),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: defaultFormField(
                                      type: TextInputType.number,
                                      prefix: Icons.confirmation_num_outlined,
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
                                    LocaleKeys
                                            .sellerCreateProductScreen_discount
                                            .tr() +
                                        ' : ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15.0,
                                        color: Colors.black45),
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
                                    if (DashboardCubit.get(context)
                                        .discountToggle) {
                                      return LocaleKeys
                                          .sellerCreateProductScreen_pleaseEnterDiscount
                                          .tr();
                                    }
                                  }
                                },
                                isClickable:
                                    DashboardCubit.get(context).discountToggle,
                                isPassword: false,
                                controller: discountController,
                                label: LocaleKeys
                                        .sellerCreateProductScreen_discount
                                        .tr() +
                                    ' %',
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    LocaleKeys
                                            .sellerCreateProductScreen_delivery
                                            .tr() +
                                        ':  ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15.0,
                                        color: Colors.black45),
                                  ),
                                  Switch(
                                      value: DashboardCubit.get(context)
                                          .deliveryToggle,
                                      onChanged: (v) {
                                        DashboardCubit.get(context)
                                            .changeDeliveryValue(v);
                                      }),
                                ],
                              ),
                              defaultFormField(
                                type: TextInputType.number,
                                prefix: Icons.monetization_on_outlined,
                                isValidate: true,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    if (DashboardCubit.get(context)
                                        .deliveryToggle) {
                                      return LocaleKeys
                                          .sellerCreateProductScreen_pleaseEnterDeliveryCost
                                          .tr();
                                    }
                                  }
                                },
                                isClickable:
                                    DashboardCubit.get(context).deliveryToggle,
                                isPassword: false,
                                controller: costController,
                                label: LocaleKeys.sellerCreateProductScreen_cost
                                    .tr(),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              ConditionalBuilder(
                                condition: state is! CreateProductLoadingState,
                                builder: (context) => defaultButton(
                                  width: MediaQuery.of(context).size.width,
                                  radius: 20.0,
                                  height: 50.0,
                                  text: LocaleKeys
                                      .sellerCreateProductScreen_submit
                                      .tr(),
                                  function: () {
                                    if (formKey.currentState.validate()) {
                                      DashboardCubit.get(context).createProduct(
                                        image: images,
                                        category: category,
                                        description: description,
                                        name: name,
                                        price: int.parse(priceController.text),
                                        oldPrice: 0,
                                        discount:
                                            discountController.text.isNotEmpty
                                                ? double.parse(
                                                    discountController.text)
                                                : 0.0,
                                        // image: images,
                                        pbid: DashboardCubit.get(context)
                                            .createId(6),
                                        isS: DashboardCubit.get(context).isS,
                                        isM: DashboardCubit.get(context).isM,
                                        isL: DashboardCubit.get(context).isL,
                                        isXL: DashboardCubit.get(context).isXL,
                                        is2XL:
                                            DashboardCubit.get(context).is2XL,
                                        is3XL:
                                            DashboardCubit.get(context).is3XL,
                                        is4XL:
                                            DashboardCubit.get(context).is4XL,
                                        is5XL:
                                            DashboardCubit.get(context).is5XL,
                                        isShipping: DashboardCubit.get(context)
                                            .deliveryToggle,
                                        isDiscount: DashboardCubit.get(context)
                                            .discountToggle,
                                        shippingPrice:
                                            costController.text ?? '0',
                                        state: 'Pending',
                                      );
                                    }
                                  },
                                  background: Colors.black,
                                ),
                                fallback: (context) => const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.black,
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
