import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/dashboard_layout/cubit/cubit.dart';
import '../../../layout/dashboard_layout/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../translations/locale_keys.g.dart';

class CreateOfferScreen extends StatelessWidget {
  const CreateOfferScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var discountController = TextEditingController();
    var promoController = TextEditingController();
    return BlocConsumer<DashboardCubit, DashboardStates>(
      listener: (context, state) {
        // if (state is CreateProductSuccessState) {
        // }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15.0,
                  ),
                  SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(children: [
                                Text(
                                    LocaleKeys.promoCodesScreen_promoCode.tr() +
                                        ':  '),
                              ]),
                            ),
                            defaultFormField(
                              type: TextInputType.text,
                              prefix: Icons.local_offer_outlined,
                              isValidate: true,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return LocaleKeys.sellerAcountScreen_pleaseEnterPromoCode.tr();
                                }
                              },
                              onChange: (String v) {
                                promoController.text.toUpperCase();

                                if (v.length > 8) {
                                  log('true');
                                  promoController.text = promoController.text
                                      .substring(
                                          0, promoController.text.length - 1);
                                }
                              },
                              isPassword: false,
                              controller: promoController,
                              label: LocaleKeys.promoCodesScreen_promoCode.tr(),
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  LocaleKeys.promoCodesScreen_discount.tr() +
                                      ':  ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15.0,
                                      color: Colors.black45),
                                ),
                                Switch(
                                    value: DashboardCubit.get(context)
                                        .promoDiscountToggle,
                                    onChanged: (v) {
                                      DashboardCubit.get(context)
                                          .changePromoDiscountValue(v);
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
                                      .promoDiscountToggle) {
                                    return LocaleKeys.sellerAcountScreen_pleaseEnterDiscount.tr();
                                  }
                                }
                              },
                              isClickable: DashboardCubit.get(context)
                                  .promoDiscountToggle,
                              isPassword: false,
                              controller: discountController,
                              label: LocaleKeys.promoCodesScreen_discount.tr() +
                                  '%',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: defaultButton(
                        function: () async {
                          if (formKey.currentState.validate()) {
                            log('message');
                            DashboardCubit.get(context).createPromo(
                              discount: int.parse(discountController.text),
                              isDiscount: DashboardCubit.get(context)
                                  .promoDiscountToggle,
                              promo: promoController.text.toUpperCase(),
                            );
                            await DashboardCubit.get(context).getPromoCodes();
                            showToast(
                                text: LocaleKeys.sellerAcountScreen_promoCodeCreated.tr(),
                                state: ToastStates.success);
                            DashboardCubit.get(context)
                                .changePromoDiscountValue(false);
                            Navigator.pop(context);
                          }
                        },
                        text: LocaleKeys.promoCodesScreen_submit.tr(),
                        isUpperCase: true,
                        width: 300.0,
                        height: 50.0,
                        radius: 15.0),
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
